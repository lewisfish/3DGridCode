module inttau2
!! Module contains routines related to the optical depth integration of a photon though a 3D grid.
    
    use constants, only : wp
    
    implicit none
   
   private
   public :: tauint1

contains

    subroutine tauint1(packet, grid)
    !! optical depth integration subroutine. The main workhorse of MCRT

        use gridset_mod,  only : cart_grid
        use iarray,       only : rhokap
        use photon_class, only : photon
        use random_mod,   only : ran2
        use vector_class, only : vector
        
        !> packet to move through the grid
        type(photon),    intent(inout) :: packet
        !> grid that the packet moves through
        type(cart_grid), intent(in)    :: grid

        ! intermediate position
        type(vector)  :: pos
        real(kind=wp) :: tau, taurun, taucell, d, dcell
        integer :: celli, cellj, cellk
        logical :: dir(3)

        !change grid origin to lower left of the grid
        pos = packet%pos + grid%dim

        ! store current voxel in temp variables
        celli = packet%xcell
        cellj = packet%ycell
        cellk = packet%zcell

        ! setup to start integrating
        taurun = 0._wp
        d = 0._wp

        !sample optical distance
        tau = -log(ran2())
        do
            dir = [.false., .false., .false.]
            !get distance to nearest wall in direction dir
            dcell = wall_dist(packet, grid, celli, cellj, cellk, pos, dir)
            !calculate optical distnace to cell wall
            taucell = dcell * rhokap(celli,cellj,cellk)

            if(taurun + taucell < tau)then!still some tau to move
                taurun = taurun + taucell
                d = d + dcell

                call update_pos(packet, grid, pos, celli, cellj, cellk, dcell, .true., dir)
            else!moved full distance

                dcell = (tau - taurun) / rhokap(celli,cellj,cellk)
                d = d + dcell

                call update_pos(packet, grid, pos, celli, cellj, cellk, dcell, .false., dir)
                exit
            end if
            if(celli == -1 .or. cellj == -1 .or. cellk == -1)then
                packet%tflag = .true.
                exit
            end if
        end do
        
        ! move back to grid with origin at the centre
        packet%pos = pos - grid%dim
        packet%xcell = celli
        packet%ycell = cellj
        packet%zcell = cellk

    end subroutine tauint1
   
    real(kind=wp) function wall_dist(packet, grid, celli, cellj, cellk, pos, dir)
    !!function that returns distant to nearest wall and which wall that is (x ,y or z)

        use gridset_mod,  only : cart_grid
        use photon_class, only : photon
        use vector_class, only : vector

        !> photon packet
        type(photon),    intent(inout) :: packet
        !> grid variable container
        type(cart_grid), intent(in)    :: grid
        !> current position
        type(vector),    intent(inout) :: pos
        !> which wall will we hit. Stored as array of bools
        logical,         intent(inout) :: dir(:)
        !> current voxel ID
        integer,         intent(inout) :: celli, cellj, cellk
        
        real(kind=wp) :: dx, dy, dz

        dx = 10000._wp
        dy = 10000._wp
        dz = 10000._wp

        ! get distance to a wall in the x direction
        if(packet%dir%x > 0._wp)then
            dx = (grid%xface(celli+1) - pos%x)*packet%inv_dir%x
        elseif(packet%dir%x < 0._wp)then
            dx = (grid%xface(celli) - pos%x)*packet%inv_dir%x
        end if

        ! get distance to a wall in the y direction
        if(packet%dir%y > 0._wp)then
            dy = (grid%yface(cellj+1) - pos%y)*packet%inv_dir%y
        elseif(packet%dir%y < 0._wp)then
            dy = (grid%yface(cellj) - pos%y)*packet%inv_dir%y
        end if

        ! get distance to a wall in the z direction
        if(packet%dir%z > 0._wp)then
            dz = (grid%zface(cellk+1) - pos%z)*packet%inv_dir%z
        elseif(packet%dir%z < 0._wp)then
            dz = (grid%zface(cellk) - pos%z)*packet%inv_dir%z
        end if

        !get closest wall
        wall_dist = min(dx, dy, dz)
        if(wall_dist < 0._wp)print'(A,7F9.5)','dcell < 0.0 warning! ',wall_dist,dx,dy,dz,packet%dir
        if(wall_dist == dx)dir=[.true., .false., .false.]
        if(wall_dist == dy)dir=[.false., .true., .false.]
        if(wall_dist == dz)dir=[.false., .false., .true.]
        if(.not.dir(1) .and. .not.dir(2) .and. .not.dir(3))print*,'Error in dir flag'
      
    end function wall_dist


    subroutine update_pos(packet, grid, pos, celli, cellj, cellk, dcell, wall_flag, dir)
    !! routine that upates postions of photon and calls fresnel routines if photon leaves current voxel

        use gridset_mod,  only : cart_grid
        use photon_class, only : photon
        use random_mod,   only : ran2
        use utils,        only : str
        use vector_class, only : vector

        !> photon object
        type(photon),    intent(in)    :: packet      
        !> current photon position
        type(vector),    intent(inout) :: pos
        !> grid object
        type(cart_grid), intent(in)    :: grid
        !> distance phton will travel across a cell
        real(kind=wp),   intent(in)    :: dcell
        !> current voxel ID
        integer,         intent(inout) :: celli, cellj, cellk
        !> flag is true if we hit a cell wall
        logical,         intent(in)    :: wall_flag
        !> logical array. 1 entry is always true. the true entry represents which cell wall we will hit
        logical,         intent(in)    :: dir(:)
    
        ! if we hit a wall
        if(wall_flag)then
            ! in the x direction
            if(dir(1))then
                if(packet%dir%x > 0._wp)then
                    celli = celli + 1
                    pos%x = grid%xface(celli) + grid%delta
                elseif(packet%dir%x < 0._wp)then
                    pos%x = grid%xface(celli) - grid%delta
                    celli = celli - 1
                else
                    error stop 'Error in x dir in update_pos'
                end if
                pos%y = pos%y + packet%dir%y*dcell 
                pos%z = pos%z + packet%dir%z*dcell
            ! y direction
            elseif(dir(2))then
                if(packet%dir%y > 0._wp)then
                    cellj = cellj + 1
                    pos%y = grid%yface(cellj) + grid%delta
                    elseif(packet%dir%y < 0._wp)then
                        pos%y = grid%yface(cellj) - grid%delta
                        cellj = cellj - 1
                    else
                        error stop 'Error in y dir in update_pos'
                    end if
                pos%x = pos%x + packet%dir%x*dcell
                pos%z = pos%z + packet%dir%z*dcell
            ! z direction
            elseif(dir(3))then
                if(packet%dir%z > 0._wp)then
                    cellk = cellk + 1
                    pos%z = grid%zface(cellk) + grid%delta
                elseif(packet%dir%z < 0._wp)then
                    pos%z = grid%zface(cellk) - grid%delta
                    cellk = cellk - 1
                else
                    error stop 'Error in z dir in update_pos'
                end if
                pos%x = pos%x + packet%dir%x*dcell
                pos%y = pos%y + packet%dir%y*dcell 
            else
                error stop 'Error in update_pos...'
            end if
        else
            ! we dont hit a wall
            pos = pos + packet%dir * dcell
        end if
        !check if we are still in the grid
        if(celli > grid%nxg .or. celli < 1)celli = -1
        if(cellj > grid%nyg .or. cellj < 1)cellj = -1
        if(cellk > grid%nzg .or. cellk < 1)cellk = -1

    end subroutine update_pos
end module inttau2
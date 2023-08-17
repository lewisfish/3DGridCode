program mcpolar

    !imports
    use constants,                only : resdir
    use gridset_mod,              only : gridset, cart_grid
    use inttau2,                  only : tauint1
    use optical_properties_class, only : optical_properties, init_opt_sphere
    use photon_class,             only : photon
    use random_mod,               only : ran2, init_seed
    use sourceph_mod,             only : isotropic_point_src
    use utils,                    only : set_directories, str
    use writer_mod,               only : writer

    implicit none

    !> variable that holds all information about the photon to be simulated
    type(photon)     :: packet
    !> variable that holds the 3D grid information
    type(cart_grid)  :: grid
    !> optical properties variable
    type(optical_properties) :: opt_prop
    !> number of photons to run in the simulation
    integer          :: nphotons
    !> counter for number of scatterings for all photons
    double precision :: nscatt
    !> user defined seed
    integer :: seed
    !> temp variable or related to I/O from param file
    integer          :: nxg, nyg, nzg, j, u
    real             :: xmax, ymax, zmax, ran
    !> timing vars
    real             :: start, finish

    call cpu_time(start)

    !set directory paths
    call set_directories()
    !set optical properties
    call init_opt_sphere(opt_prop)

    !set random seed
    seed = 42
    call init_seed(seed)

    !**** Read in parameters from the file input.params
    open(newunit=u,file=trim(resdir)//'input.params',status='old')
        read(u,*) nphotons
        read(u,*) xmax
        read(u,*) ymax
        read(u,*) zmax
        read(u,*) nxg
        read(u,*) nyg
        read(u,*) nzg
    close(u)

    print*, ''      
    print*,'# of photons to run',nphotons

    ! Set up grid
    call gridset(grid, opt_prop, nxg, nyg, nzg, xmax, ymax, zmax)

    ! inialise the number of scatterings counter
    nscatt = 0

    print*,'Photons now running'
    !loop over photons 
    do j = 1, nphotons

        !display progress
        if(mod(j,10000) == 0)then
            print *, str(j)//' scattered photons completed'
        end if

        ! Release photon from point source
        call isotropic_point_src(packet, grid)
        
        ! Find scattering location
        call tauint1(packet, grid)
        ! Photon scatters in grid until it exits (tflag=TRUE) 
        do while(.not. packet%tflag)

            ran = ran2()
            !interact with medium
            if(ran < opt_prop%albedo)then
                ! photon is scattered
                call packet%scatter(opt_prop)
                nscatt = nscatt + 1        
            else
                ! photon is absorbed
                packet%tflag=.true.
                exit
            end if

            ! Find next scattering location
            call tauint1(packet, grid)

        end do
    end do      ! end loop over nph photons

    print*,'Average # of scatters per photon: '//str(nscatt/(nphotons))
    !write out files
    call writer(grid, nphotons)
    print*,'write done'

    call cpu_time(finish)

    if(finish-start >= 60.)then
        print*,floor((finish-start)/60.)+mod(finish-start,60.)/100.
    else
        print*, 'time taken ~'//str(floor(finish-start/60.))//'s'
    end if

end program mcpolar
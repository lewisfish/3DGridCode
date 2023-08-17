module sourceph_mod
!! Module contains the routines to inialise a photon, i.e different light sources.
    implicit none

    contains
        subroutine isotropic_point_src(packet, grid)
        !! set intial photon position at (0.0, 0.0, 0.0) and sample photon direction in an isotropic manner.

            use constants,    only : TWOPI
            use gridset_mod,  only :cart_grid
            use photon_class, only : photon
            use random_mod,   only : ran2

            !> photon object
            type(photon),    intent(out) :: packet
            !> grid object
            type(cart_grid), intent(in)  :: grid

            !set packet position
            packet%pos%z = 0.0
            packet%pos%x = 0.0
            packet%pos%y = 0.0

            ! set packet cosines
            packet%phi  = ran2()*twoPI
            packet%cosp = cos(packet%phi)
            packet%sinp = sin(packet%phi)
            packet%cost = 2.*ran2()-1.
            packet%sint = sqrt(1. - packet%cost**2)

            ! set direction vector
            packet%dir%x = packet%sint * packet%cosp  
            packet%dir%y = packet%sint * packet%sinp
            packet%dir%z = packet%cost

            ! set packet voxel
            packet%xcell=int(grid%nxg*(packet%pos%x+grid%dim%x)/(2.*grid%dim%x))+1
            packet%ycell=int(grid%nyg*(packet%pos%y+grid%dim%y)/(2.*grid%dim%y))+1
            packet%zcell=int(grid%nzg*(packet%pos%z+grid%dim%z)/(2.*grid%dim%z))+1

            packet%tflag = .false.

        end subroutine isotropic_point_src
end module sourceph_mod

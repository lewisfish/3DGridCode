module photon_class
!! Module defines the photon class and scattering routines
    
    use vector_class, only : vector

    implicit none

    !> photon type. Encapsulates all information about a single photon.
    type :: photon
        !> direction vector
        type(vector) :: dir
        !> position vector
        type(vector) :: pos
        !> direction angles
        real :: sint, cost, sinp, cosp, phi
        !> Boolean flag that if true photon is alive and in the simulation
        logical :: tflag
        !> Current voxel which the photon is in
        integer :: xcell, ycell, zcell

        contains
        procedure :: scatter
    end type photon

    contains

    subroutine scatter(this, opt_prop)
        !! photon scattering routine. Handles both isotropic (hgg=0) and henyey-greenstein scattering (hgg /=0)
        !! adapted from mcxyz https://omlc.org/software/mc/mcxyz/index.html
    
            use optical_properties_class, only : optical_properties
            use constants,    only : PI, TWOPI
            use random_mod,   only : ran2
    
            !> photon packet
            class(photon) :: this
            !> optical properties
            type(optical_properties), intent(in) :: opt_prop
    
            real :: temp, uxx, uyy, uzz
    
            if(opt_prop%hgg == 0.0)then
                !isotropic scattering
                this%cost = 2. * ran2() - 1.
            else
                !henyey-greenstein scattering
                temp = (1.0 - opt_prop%g2) / (1.0 - opt_prop%hgg + 2.*opt_prop%hgg*ran2())
                this%cost = (1.0 + opt_prop%g2 - temp**2) / (2.*opt_prop%hgg)
            end if
    
            this%sint = sqrt(1. - this%cost**2)
    
            this%phi = TWOPI * ran2()
            this%cosp = cos(this%phi)
            if(this%phi < PI)then
                this%sinp = sqrt(1. - this%cosp**2)
            else
                this%sinp = -sqrt(1. - this%cosp**2)
            end if
    
            if(1. - abs(this%dir%z) <= 1e-12)then ! near perpindicular
                uxx = this%sint * this%cosp
                uyy = this%sint * this%sinp
                uzz = sign(this%cost, this%dir%z)
            else
                temp = sqrt(1. - this%dir%z**2)
                uxx = this%sint * (this%dir%x * this%dir%z * this%cosp - this%dir%y * this%sinp) &
                        / temp + this%dir%x * this%cost
                uyy = this%sint * (this%dir%y * this%dir%z * this%cosp + this%dir%x * this%sinp) &
                        / temp + this%dir%y * this%cost
                uzz = -1.*this%sint * this%cosp * temp + this%dir%z * this%cost
            end if
    
            this%dir%x = uxx
            this%dir%y = uyy
            this%dir%z = uzz
    
        end subroutine scatter

end module photon_class

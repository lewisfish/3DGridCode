module photon_class
!! Module defines the photon class and scattering routines
    
    use constants,    only : wp
    use vector_class, only : vector, inverse

    implicit none

    !> photon type. Encapsulates all information about a single photon.
    type :: photon
        !> direction vector
        type(vector) :: dir
        !> Inverse direction vector (1.0 / dir). Saves some compute time
        type(vector) :: inv_dir
        !> position vector
        type(vector) :: pos
        !> \(sin(theta)\). \(\theta\) is the polar angle in the physics spherical coordinate system 
        real(kind=wp) :: sint
        !> \(cos(\theta)\) \(\theta\) is the polar angle in the physics spherical coordinate system
        real(kind=wp) :: cost
        !> \(sin(\phi)\) \(\phi\) is the azimuthal angle in the physics spherical coordinate system
        real(kind=wp) :: sinp
        !> \(cos(\phi)\) \(\phi\) is the azimuthal angle in the physics spherical coordinate system
        real(kind=wp) :: cosp
        !> \(\phi\) \(\phi\) is the azimuthal angle in the physics spherical coordinate system
        real(kind=wp) :: phi
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
        !! adapted from mcxyz [https://omlc.org/software/mc/mcxyz/index.html](https://omlc.org/software/mc/mcxyz/index.html)
    
            use optical_properties_class, only : optical_properties
            use constants,    only : PI, TWOPI
            use random_mod,   only : ran2
    
            !> photon packet
            class(photon) :: this
            !> optical properties
            type(optical_properties), intent(in) :: opt_prop
    
            real(kind=wp) :: temp, uxx, uyy, uzz
    
            if(opt_prop%hgg == 0.0_wp)then
                !isotropic scattering
                this%cost = 2._wp * ran2() - 1._wp
            else
                !henyey-greenstein scattering
                temp = (1.0_wp - opt_prop%g2) / (1.0_wp - opt_prop%hgg + 2._wp*opt_prop%hgg*ran2())
                this%cost = (1.0_wp + opt_prop%g2 - temp**2) / (2._wp*opt_prop%hgg)
            end if
    
            this%sint = sqrt(1._wp - this%cost**2)
    
            this%phi = TWOPI * ran2()
            this%cosp = cos(this%phi)
            if(this%phi < PI)then
                this%sinp = sqrt(1._wp - this%cosp**2)
            else
                this%sinp = -sqrt(1._wp - this%cosp**2)
            end if
    
            if(1._wp - abs(this%dir%z) <= 1e-12_wp)then ! near perpindicular
                uxx = this%sint * this%cosp
                uyy = this%sint * this%sinp
                uzz = sign(this%cost, this%dir%z)
            else
                temp = sqrt(1._wp - this%dir%z**2)
                uxx = this%sint * (this%dir%x * this%dir%z * this%cosp - this%dir%y * this%sinp) &
                        / temp + this%dir%x * this%cost
                uyy = this%sint * (this%dir%y * this%dir%z * this%cosp + this%dir%x * this%sinp) &
                        / temp + this%dir%y * this%cost
                uzz = -1.*this%sint * this%cosp * temp + this%dir%z * this%cost
            end if
    
            this%dir%x = uxx
            this%dir%y = uyy
            this%dir%z = uzz

            this%inv_dir = inverse(this%dir)
    
        end subroutine scatter

end module photon_class

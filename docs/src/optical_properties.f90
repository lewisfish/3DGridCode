module optical_properties_class
    !! Change optical properties
    !! Set the \(\mu_s\) (scattering coefficient), \(\mu_a\)(absorption coefficient) both in cm\(^{-1}\), and hgg (g factor).

    implicit none

    type :: optical_properties
        real :: mus, mua, hgg, g2, kappa, albedo
    end type optical_properties

    private
    public :: optical_properties, init_opt_sphere, init_opt2

    contains
    
        subroutine init_opt_sphere(opt_prop)
        !!  Set tissue optical properties so that total optical depth in a sphere of radius 1cm is 10.
            
            type(optical_properties), intent(out) :: opt_prop

                opt_prop%hgg = 0.0d0
                opt_prop%g2  = opt_prop%hgg**2.
                opt_prop%mua = 0.0
                opt_prop%mus = 10.0

                opt_prop%kappa  = opt_prop%mus + opt_prop%mua
                opt_prop%albedo = opt_prop%mus / opt_prop%kappa
    
        end subroutine init_opt_sphere
        
        subroutine init_opt2(opt_prop)
        !!  Set tissue optical properties 420nm
    
            type(optical_properties), intent(out) :: opt_prop

            opt_prop%hgg = 0.9
            opt_prop%g2  = opt_prop%hgg**2.
            opt_prop%mua = 1.8
            opt_prop%mus = 82.0/(1.0 - opt_prop%hgg)

            opt_prop%kappa  = opt_prop%mus + opt_prop%mua
            opt_prop%albedo = opt_prop%mus / opt_prop%kappa
    
        end subroutine init_opt2
end module optical_properties_class

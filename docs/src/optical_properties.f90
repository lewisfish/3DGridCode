module optical_properties_class
    !! Change optical properties
    !! Set the \(\mu_s\) (scattering coefficient), \(\mu_a\)(absorption coefficient) both in cm\(^{-1}\), and hgg (g factor).

    implicit none

    !> Stores the optical properties of the medium. Currently only 1 media type. Can expand by making these arrays.
    type :: optical_properties
        !> \(\mu_s\) is the scattering coefficent. in cm\(^{-1}\)   
        real :: mus
        !> \(\mu_a\) is the absorption coefficent. in cm\(^{-1}\)
        real :: mua
        !> hgg is the g factor. Describes the bias of the scattering direction. 1 means forward, 0 isotropic and -1 backscattering. unitless   
        real :: hgg
        !> Is the g factor squared
        real :: g2
        !> \(\kappa\) is \(\mu_s\) + \(\mu_a\) 
        real :: kappa
        !> The albedo is \(\frac{\mu_s}{\mu_a+\mu_s}\)
        real :: albedo
    end type optical_properties

    private
    public :: optical_properties, init_opt_sphere, init_opt2

    contains
    
        subroutine init_opt_sphere(opt_prop)
        !!  Set tissue optical properties so that total optical depth in a sphere of radius 1cm is 10.
            !> optical property container
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

            !> optical property container
            type(optical_properties), intent(out) :: opt_prop

            opt_prop%hgg = 0.9
            opt_prop%g2  = opt_prop%hgg**2.
            opt_prop%mua = 1.8
            opt_prop%mus = 82.0/(1.0 - opt_prop%hgg)

            opt_prop%kappa  = opt_prop%mus + opt_prop%mua
            opt_prop%albedo = opt_prop%mus / opt_prop%kappa
    
        end subroutine init_opt2
end module optical_properties_class

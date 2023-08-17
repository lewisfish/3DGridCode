module iarray
!!  Contains all array variable names.

    use constants, only : wp

    implicit none
    !> stores the optical properties, i.e the total cross section \(\mu_t = \mu_s + \mu_a\)
    real(kind=wp), allocatable :: rhokap(:,:,:)
end module iarray

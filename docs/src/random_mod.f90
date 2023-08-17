module random_mod
    !! module containg routines related to random numbers

    implicit none
    
    private
    public :: ran2, ranu, init_seed

contains
    
    subroutine init_seed(seed)
    !! user convenience function for setting random generator seed
        !> user defined seed
        integer, intent(in) :: seed

        !> size of internal seed array
        integer :: n
        !> internal seed array to be filled with user defined seed
        integer, allocatable :: iseed(:)

        ! get seed size
        call random_seed(size=n)
        allocate(iseed(n))

        ! put user seed in actual seed
        iseed = seed
        ! seed the RNG
        call random_seed(put=iseed)

    end subroutine init_seed

    real function ran2()
    !! Wrapper function to fortran internal random number generator
    !! Generates a random number in the range [0,1.)
        call random_number(ran2)

    end function ran2

    real function ranu(a, b)
    !! sample uniformly between [a, b]
        !> input lower bound
        real, intent(in) :: a
        !> input upper bound
        real, intent(in) ::b

        ranu = a + ran2() * (b - a)

        end function ranu
end module random_mod
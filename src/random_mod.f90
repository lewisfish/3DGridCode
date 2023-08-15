module random_mod
    !! module containg routines related to random numbers

    implicit none
    
    private
    public :: ran2, ranu

contains
    
    real function ran2()
    !! Wrapper function to fortran internal random number generator
    !! Generates a random number in the range [0,1.)
        call random_number(ran2)

    end function ran2

    real function ranu(a, b)
    !! sample uniformly between [a, b]
        real, intent(IN) :: a, b

        ranu = a + ran2() * (b - a)

        end function ranu
end module random_mod
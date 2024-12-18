module writer_mod
    !! I/O related routines.

implicit none

    contains
        subroutine writer(grid, nphotons)
        !! subroutine to write out normalised fluence

            use constants,   only : fileplace
            use gridset_mod, only : cart_grid

            !> grid
            type(cart_grid), intent(in) :: grid
            !> number of photons to normalise by
            integer, intent(in) :: nphotons

            integer :: u
            
            ! normalise fluence assuming power is 1W

            ! write out fluence
            open(newunit=u, file=, form="unformatted", access="stream")
            write(u)
            close(u)

        
        end subroutine writer
end module writer_mod

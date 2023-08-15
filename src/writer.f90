module writer_mod
    !! I/O related routines.

implicit none

    contains
        subroutine writer(grid, nphotons)
        !! subroutine to write out normalised fluence

            use constants,   only : fileplace
            use iarray,      only : jmean
            use gridset_mod, only : cart_grid

            !> grid
            type(cart_grid), intent(in) :: grid
            !> number of photons to normalise by
            integer, intent(in) :: nphotons
            
            ! file handle
            integer :: u
            real :: xmax, ymax, zmax

            xmax = 2.*grid%dim%x
            ymax = 2.*grid%dim%y
            zmax = 2.*grid%dim%z

            ! normalise fluence assuming power is 1W
            jmean = jmean * ((xmax)**2./(nphotons*(xmax/grid%nxg)*(ymax/grid%nyg)*(zmax/grid%nzg)))

            ! write out fluence
            open(newunit=u,file=trim(fileplace)//'jmean/fluence.dat',access='stream',status='replace',form='unformatted')
            write(u) jmean
            close(u)

        end subroutine writer
end module writer_mod

module constants
!! Constants used throughout the simulation.

    implicit none
    !> mathematical constants
    real,    parameter :: PI=4.*atan(1.), TWOPI=2.*PI
    !> variables that store directories for files etc
    character(len=255) :: cwd, homedir, fileplace, resdir

end module constants
module constants
!! Constants used throughout the simulation.

    implicit none
    !> mathematical constants
    real,    parameter :: PI=4.*atan(1.), TWOPI=2.*PI
    !> variables that stores the home (root) directory
    character(len=255) ::  homedir
    !> variables that stores the directory where output files are saved
    character(len=255) ::  fileplace
    !> variables that stores the directory for input files.
    character(len=255) ::  resdir

end module constants
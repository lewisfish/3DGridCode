module constants
!! Constants used throughout the simulation.
    use iso_fortran_env, only : real64, real32

    implicit none
    !> set working precision as double precision. Lower or higher precisions not tested.
    integer, parameter :: wp = real64
    !> mathematical constants
    real(kind=wp), parameter :: PI=4._wp*atan(1._wp), TWOPI=2._wp*PI
    !> variables that stores the home (root) directory
    character(len=255) ::  homedir
    !> variables that stores the directory where output files are saved
    character(len=255) ::  fileplace
    !> variables that stores the directory for input files.
    character(len=255) ::  resdir

end module constants
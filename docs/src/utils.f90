module utils
!! module that contains utility functions and helper routines. 
    
    use constants, only: wp

    implicit none

    !>functions to turn numerical variables into strings
    interface str
        module procedure str_I32
        module procedure str_I64
        module procedure str_Iarray
        module procedure str_R8
        module procedure str_R8array
        module procedure str_logicalarray
    end interface str

    private
    public :: str, set_directories

    contains

        subroutine set_directories()
        !! define variables to hold paths to various folders   

            use constants, only : homedir, fileplace, resdir

            character(len=255) :: cwd

            !get current working directory
            call get_environment_variable('PWD', cwd)

            ! get 'home' dir from cwd
            if(index(cwd, "bin") > 0)then
                ! if program is run from bin dir
                homedir = trim(cwd(1:len(trim(cwd))-3))
            else
                ! program is run from root dir
                homedir = trim(cwd) // "/"
            end if

            ! get data dir
            fileplace = trim(homedir)//'data/'
            ! get res dir
            resdir = trim(homedir)//'res/'

        end subroutine set_directories


        function str_I32(i)
        !! convert an int32 integer into a string

            use iso_fortran_env, only : Int32

            !> input int to convert into string
            integer(int32), intent(IN) :: i

            character(len=:), allocatable :: str_I32
            character(len=100) :: string

            write(string,'(I100.1)') I

            str_I32 = trim(adjustl(string))
        end function str_I32


        function str_I64(i)
        !! convert an int64 integer into a string

            use iso_fortran_env, only : Int64

            !> input int to convert into string
            integer(Int64), intent(IN) :: i

            character(len=:), allocatable :: str_I64
            character(len=100) :: string

            write(string,'(I100.1)') I

            str_I64 = trim(adjustl(string))
        end function str_I64


        function str_iarray(i)
        !! convert an int32 integer array into a string

            !> input int array to convert into string
            integer, intent(IN) :: i(:)

            character(len=:), allocatable :: str_iarray
            character(len=100) :: string
            integer :: j

            do j = 1, size(i)
                write(string,'(I100.1)') I(j)
                str_iarray = str_iarray//' '//trim(adjustl(string))
            end do
            
        end function str_iarray

        function str_R8(i)
        !! convert an double precision float into a string

            !> input float to convert into string
            real(kind=wp), intent(IN) :: i

            character(len=:), allocatable :: str_R8
            character(len=100) :: string

            write(string,'(f100.16)') I

            str_R8 = trim(adjustl(string))
        end function str_r8


        function str_R8array(a)
        !! convert an double precision float array into a string

            !> input float array to convert into string
            real(kind=wp), intent(IN) :: a(:)

            character(len=:), allocatable :: str_R8array
            character(len=100) :: string
            integer :: i

            do i = 1, size(a)
                write(string,'(f100.16)') a(i)
                str_R8array = str_R8array//' '//trim(adjustl(string))
            end do

        end function str_R8array


        function str_logicalarray(a)
        !! convert an logical array into a string

            !> input logical array to convert into string
            logical, intent(IN) :: a(:)

            character(len=:), allocatable :: str_logicalarray
            character(len=100) :: string
            integer :: i

            do i = 1, size(a)
                write(string,'(L1)') a(i)
                str_logicalarray = str_logicalarray//' '//trim(adjustl(string))
            end do

        end function str_logicalarray
end module utils
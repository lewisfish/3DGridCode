module gridset_mod
!! Module provides a cartesian grid type to store all grid related variables in a container
!! Also provides a way of setting up the geomerty/grid for the simulation.

    use vector_class, only : vector

    implicit none

    private
    public :: gridset, cart_grid

    !> 3D cartesian grid. Stores information about the linear voxel grid
    type :: cart_grid
        !> Size of grid in voxels in each direction
        integer :: nxg, nyg, nzg
        !> half size of grid in each dimension. cm
        type(vector) :: dim
        !> Arrays that store the location of each grid cell(voxel) wall
        real, allocatable :: xface(:), yface(:), zface(:)
        !> ! Set small distance for use in optical depth integration routines for roundoff effects when crossing cell walls
        real :: delta
    end type cart_grid

    contains
        subroutine gridset(grid, opt_prop, nxg, nyg, nzg, xmax, ymax, zmax)
        !! Set up grids and create geometry

            use iarray,   only : rhokap, rhokap
            use optical_properties_class, only : optical_properties

            !> grid variable that is assigned in this routine
            type(cart_grid),          intent(out) :: grid
            !> optical properties used to setup voxel geometry
            type(optical_properties), intent(in)  :: opt_prop
            !> number of voxels in each dimension
            integer,                  intent(in)  :: nxg, nyg, nzg
            !> half size of the grid in cm
            real,                     intent(in)  :: xmax, ymax, zmax
            
            !> loop variables
            integer :: i, j, k
            !> temp variables
            real    :: x, y, z, taueq1, taupole1, taueq2, taupole2

            print*, ' '
            print *, 'Setting up grid....'

            ! set grid dimensions and voxel numbers
            grid%dim = vector(xmax, ymax, zmax)
            grid%nxg = nxg
            grid%nyg = nyg
            grid%nzg = nzg

            ! Set small distance for use in optical depth integration routines 
            ! for roundoff effects when crossing cell walls
            grid%delta = 1.e-8*(2.*grid%dim%z/grid%nzg)

            ! allocate and set arrays to 0
            call alloc_array(grid)
            call zarray(grid)

            ! setup grid cell walls
            do i = 1, grid%nxg + 1
                grid%xface(i) = (i - 1) * 2. * grid%dim%x/grid%nxg
            end do

            do i = 1, grid%nyg + 1
                grid%yface(i) = (i - 1) * 2. * grid%dim%y/grid%nyg
            end do

            do i = 1, grid%nzg + 1
                grid%zface(i) = (i - 1) * 2. * grid%dim%z/grid%nzg
            end do

            !set up optical properties grid 
            do i = 1, grid%nxg
                x = grid%xface(i) - grid%dim%x + grid%dim%x/grid%nxg
                do j = 1, grid%nyg
                    y = grid%yface(j) - grid%dim%y + grid%dim%y/grid%nyg
                    do k = 1, grid%nzg
                        z = grid%zface(k) - grid%dim%z + grid%dim%z/grid%nzg
                        ! create a sphere of radius 1.
                        if(sqrt(x**2+y**2+z**2) <= 1.)then
                            rhokap(i,j,k) = opt_prop%kappa
                        else
                            rhokap(i,j,k) = 0.
                        end if
                    end do
                end do
            end do

            ! Calculate equatorial and polar optical depths
            taueq1   = 0.
            taupole1 = 0.
            taueq2   = 0.
            taupole2 = 0.

            do i = 1, grid%nxg
                taueq1 = taueq1 + rhokap(i,grid%nyg/2,grid%nzg/2)
            end do

            do i = 1, grid%nzg
                taupole1 = taupole1 + rhokap(grid%nxg/2,grid%nyg/2,i)
            end do

            taueq1 = taueq1 * 2. * grid%dim%x/grid%nxg
            taupole1 = taupole1 * 2. * grid%dim%z/grid%nzg
            print'(A,F9.5,A,F9.5)',' taueq1 = ',taueq1,'  taupole1 = ',taupole1

        end subroutine gridset

        subroutine zarray(grid)
        !! set all 3D arrays to zero

            use iarray, only: rhokap

            type(cart_grid), intent(inout) :: grid

            rhokap = 0.
            grid%xface = 0.
            grid%yface = 0.
            grid%zface = 0.
        end subroutine zarray


        subroutine alloc_array(grid)
        !!  allocates allocatable 3D arrays

            use iarray, only: rhokap

            type(cart_grid), intent(inout) :: grid

            allocate(rhokap(grid%nxg, grid%nyg, grid%nzg))
            allocate(grid%xface(grid%nxg+1))
            allocate(grid%yface(grid%nyg+1))
            allocate(grid%zface(grid%nzg+1))
        end subroutine alloc_array
end module gridset_mod

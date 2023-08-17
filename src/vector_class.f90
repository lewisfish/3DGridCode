Module vector_class
    !! Module contains the vector class and associated routines.
    
    implicit none

    !> Vector type used for direction and position vectors
    !> supports all possible vector operations
    type :: vector
        !> components of the vector
        real :: x, y, z
        contains

        !> get the magnitde of a vector
        procedure :: magnitude       => magnitude_fn
        !> print a vector
        procedure :: print           => print_sub
        !> get the dot product of two vectors
        generic   :: operator(.dot.) => vec_dot
        !> divide a vector by a float
        generic   :: operator(/)     => vec_div_scal
        !> multiple a vector by a scalar or vector (element wise)
        generic   :: operator(*)     => vec_mult_vec, vec_mult_scal, scal_mult_vec
        !> add two vectors, or a vector and a scalar
        generic   :: operator(+)     => vec_add_vec, vec_add_scal, scal_add_vec
        !> subtract a vector from a vector
        generic   :: operator(-)     => vec_minus_vec

        procedure, pass(a), private :: vec_dot

        procedure, pass(a), private :: vec_div_scal

        procedure, pass(a), private :: vec_mult_vec
        procedure, pass(a), private :: vec_mult_scal
        procedure, pass(b), private :: scal_mult_vec

        procedure, pass(a), private :: vec_add_vec
        procedure, pass(a), private :: vec_add_scal
        procedure, pass(b), private :: scal_add_vec

        procedure, pass(a), private :: vec_minus_vec

    end type vector

    private
    public :: vector

    contains

        pure type(vector) function vec_minus_vec(a, b)

            class(vector), intent(IN) :: a
            type(vector),  intent(IN) :: b

            vec_minus_vec = vector(a%x - b%x, a%y - b%y, a%z - b%z)

        end function vec_minus_vec


        pure type(vector) function vec_add_scal(a, b)

            class(vector), intent(IN) :: a
            real,          intent(IN) :: b

            vec_add_scal = vector(a%x + b, a%y + b, a%z + b)

        end function vec_add_scal


        pure type(vector) function scal_add_vec(a, b)

            class(vector), intent(IN) :: b
            real,          intent(IN) :: a

            scal_add_vec = vector(b%x + a, b%y + a, b%z + a)

        end function scal_add_vec


        pure type(vector) function vec_add_vec(a, b)

            class(vector), intent(IN) :: a
            type(vector),  intent(IN) :: b

            vec_add_vec = vector(a%x + b%x, a%y + b%y, a%z + b%z)

        end function vec_add_vec


        pure elemental function vec_dot(a, b) result (dot)

            class(vector), intent(IN) :: a
            type(vector),  intent(IN) :: b
            real :: dot

            dot = (a%x * b%x) + (a%y * b%y) + (a%z * b%z)

        end function vec_dot


        pure type(vector) function vec_mult_vec(a, b)

            class(vector), intent(IN) :: a
            type(vector),  intent(IN) :: b

            vec_mult_vec = vector(a%x * b%x, a%y * b%y, a%z * b%z)

        end function vec_mult_vec


        pure type(vector) function vec_mult_scal(a, b)

            class(vector), intent(IN) :: a
            real,          intent(IN) :: b

            vec_mult_scal = vector(a%x * b, a%y * b, a%z * b)

        end function vec_mult_scal


        pure type(vector) function scal_mult_vec(a, b)

            class(vector), intent(IN) :: b
            real,          intent(IN) :: a

            scal_mult_vec = vector(a * b%x, a * b%y, a * b%z)

        end function scal_mult_vec


        pure type(vector) function vec_div_scal(a, b)

            class(vector), intent(IN) :: a
            real,         intent(IN) :: b

            vec_div_scal = vector(a%x / b, a%y / b, a%z / b)

        end function vec_div_scal


        pure type(vector) function magnitude_fn(this)

            class(vector), intent(in) :: this

            real :: tmp

            tmp = sqrt(this%x**2 + this%y**2 + this%z**2)
            magnitude_fn = this / tmp

        end function magnitude_fn


        subroutine print_sub(this)

            class(vector) :: this

                print*,this%x, this%y, this%z

        end subroutine print_sub
end Module vector_class
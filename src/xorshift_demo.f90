program xorshift_demo

  use iso_fortran_env
  use xorshift

  implicit none

  call xorshift_init()

  call demo()

contains

  subroutine demo()
    integer(int32) :: i

    do i = 1, 100
      print '(f20.18)', rrand32()
    end do

  end subroutine demo

end program xorshift_demo

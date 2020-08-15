module xorshift

  use iso_fortran_env

  implicit none
  private

  public :: xorshift_init
  public :: irand32
  public :: irand64
  public :: rrand32
  public :: rrand64
  public :: prand32
  public :: prand64

  integer(int64), save :: s32 = 2463534242_int64
  integer(int64), save :: s64 = 88172645463324242_int64

contains

  function new_seed() result(seed)
    integer(int64) :: seed
    integer(int64) :: i, idt(8)

    call date_and_time(values=idt)

    i = 1000 * (60 * (60 * idt(5) + idt(6)) + idt(7)) + idt(8)
    seed = i * idt(1) + 2 * i * idt(2) + idt(3)
  end function new_seed

  subroutine xorshift_init()
    integer(int16) :: i
    integer(int64) :: r

    s32 = new_seed()
    s64 = new_seed()

    ! drop first 10 elements
    do i = 1, 10
      call rnd32(r)
      call rnd64(r)
    end do
  end subroutine xorshift_init

  subroutine rnd32(rnd)
    integer(int64), intent(out) :: rnd

    s32 = ieor(s32, shiftl(s32, 13))
    s32 = ieor(s32, shiftr(s32, 17))
    rnd = ieor(s32, shiftl(s32, 5))
  end subroutine rnd32

  subroutine rnd64(rnd)
    integer(int64), intent(out) :: rnd

    s64 = ieor(s64, shiftl(s64, 13))
    s64 = ieor(s64, shiftr(s64, 7))
    rnd = ieor(s64, shiftl(s64, 17))
  end subroutine rnd64

  function irand32() result(rnd)
    integer(int64) :: rnd

    call rnd32(rnd)
  end function irand32

  function irand64() result(rnd)
    integer(int64) :: rnd

    call rnd64(rnd)
  end function irand64

  function rrand32() result(rnd)
    real(real64) :: rnd
    integer(int64) :: i

    rnd = real(irand32(), real64) / real(huge(i), real64)
  end function rrand32

  function rrand64() result(rnd)
    real(real64) :: rnd
    integer(int64) :: i

    rnd = real(irand64(), real64) / real(huge(i), real64)
  end function rrand64

  function prand32() result(rnd)
    real(real64) :: rnd

    rnd = abs(rrand32())
  end function

  function prand64() result(rnd)
    real(real64) :: rnd

    rnd = abs(rrand64())
  end function

end module xorshift

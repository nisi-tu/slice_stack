module mod_long2
implicit none

integer, parameter :: Nlos = 204 - 6

integer, parameter :: Nline = 6

! line-of-sight data ( y=ax+b )
real(8) :: a(Nlos)=0.d0
real(8) :: b(Nlos)=0.d0

real(8) :: LI(Nline, Nlos)      ! experimentally observed
real(8) :: sLI(Nline, Nlos)     ! smoothed
real(8) :: calc_LI(Nline, Nlos) ! reproduced

! emissivity
real(8) :: emis(Nline, Nlos)
real(8) :: semis(Nline, Nlos)   ! smoothed

contains
! ================================================== !
subroutine rd_los( losfile )
implicit none
character(*), intent(in) :: losfile
integer :: i, dummy

    print*, ".................... ", losfile ," ...................."

    open( 102, file=losfile, status="old", action="read" )

        do i = 1, Nlos
            read(102,*) dummy, a(i), b(i)
        end do

    close(102)

end subroutine rd_los
! ================================================== !
subroutine rd_line_integ_intens( intensityfile )
implicit none
character(*), intent(in) :: intensityfile
integer :: i, dmy

    print*, ".................... ", intensityfile ," ...................."

    open(101, file=intensityfile, status="old", action="read")

        do i = 1, 10
            read(101,*)
        end do

        do i = 1, Nlos
            read(101,*) dmy, LI(1:Nline, i)
        end do
    close(101)

end subroutine rd_line_integ_intens
! ================================================== !

end module mod_long2

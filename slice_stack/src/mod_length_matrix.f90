! ================================================== !
! calculation of L matrix : epsilon = LI
! ver. 2025.7.17
! frame analysis version 2025.10.30 nisi
! ================================================== !
module mod_length_matrix
use mod_tsmesh_h
use mod_long2
use mod_math
implicit none

integer, parameter :: N = 30000
real(8) :: x(N), y(N), dx,  dL, reff_c

real(8) :: L(Nlos,Nlos)
real(8) :: div_reff(0:Nlos)=0.d0

! 視線が通る最小の reff
real(8) :: min_reff(Nlos)=1d10
real(8) :: xmin(Nlos), ymin(Nlos)

! プラズマ境界
real(8) :: border(Nlos) = -1d10
real(8) :: border_x(Nlos), border_y(Nlos)

contains
! ================================================== !
subroutine line_integration_along_los( Lfile )
implicit none
character(*), intent(in) :: Lfile
integer :: i, j, k

open(201, file=Lfile)
write(201,*) "# EUV long2 spectrometer"
write(201,*) "# reff (m), component of L (m)"

do k = 1, Nlos

    ! set plasma edge
    div_reff(0) = border(k)

        ! set (x,y) along los
        dx = (Rmax-Rmin)/dble(N-1)
        dL = sqrt( dx**2 + (a(k)*dx)**2 )   ! d(Length) of los #k
        do i = 1,N
            if(i==1) x(i) = Rmin
            if(i/=1) x(i) = x(i-1) + dX
            y(i) = a(k)*x(i) + b(k)
        end do

    ! line-integrate
    do i = 1, N
        
        call comp_2D_scalar( x(i), y(i), reff_c )
        if( reff_c == 10.d0 ) cycle

        ! judge : where the reff_c belongs to ?
        do j = 0, Nlos
            if( reff_c.lt.div_reff(j) .and. reff_c.gt.div_reff(j+1) ) then
                L(k,j+1) = L(k,j+1) + dL
            else if (reff_c == div_reff(j)) then
                ! ???
            end if
        end do

    end do

    if( mod(k,25)==1) write(*,'(A5, i6, A10, F10.4, A15, ES14.4)') &
    & "LOS#", k, "L_tot (m)", sum(L(k,1:Nlos)), "reff_min (m)", &
    & div_reff(minloc(L(k,1:Nlos)))

    write(201,'(es16.5, 198es16.5)') div_reff(k), L(k,1:Nlos)

end do

end subroutine line_integration_along_los
! ================================================== !
subroutine set_parameters
implicit none
integer :: i, j, k

    do k = 1, Nlos

        dx = (Rmax-Rmin)/dble(N-1)
        dL = sqrt( dx**2 + (a(k)*dx)**2 )   ! d(Length) of los #k

        do i = 1,N
            if(i==1) x(i) = Rmin
            if(i/=1) x(i) = x(i-1) + dX
            y(i) = a(k)*x(i) + b(k)
        end do
        
        ! line-integration
        do i = 1, N

            ! get reff on (x,y)
            call comp_2D_scalar( x(i), y(i), reff_c )

            if( reff_c .gt. 3.d0 ) cycle
            if( reff_c .lt. 0.d0 ) stop "reff_c is less than 0"

            ! find minimum reff for each LOS
            if( reff_c .lt. min_reff(k) ) then
                min_reff(k) = reff_c
                xmin(k) = x(i)
                ymin(k) = y(i)
            end if

            ! find plasma edge
            if( reff_c .gt. border(k) ) then
                border(k) = reff_c
                border_x(k) = x(i)
                border_y(k) = y(i)
            end if

        end do

        div_reff(k) = min_reff(k)
    end do

end subroutine set_parameters
! ================================================== !
subroutine comp_2D_scalar( x1, y1, comp_val )
implicit none

real(8), intent(in)  :: x1, y1
real(8), intent(out) :: comp_val
real(8) :: w1, w2, w3, w4
integer :: Rn, Zn

    Rn = int( (x1-Rmin)/dr ) + 1
    Zn = int( (y1-Zmin)/dz ) + 1

    if( reff(Rn  ,Zn  ) == 10.d0 .OR. &
      & reff(Rn+1,Zn  ) == 10.d0 .OR. &
      & reff(Rn,Zn+1  ) == 10.d0 .OR. &
      & reff(Rn+1,Zn+1) == 10.d0) then 
        comp_val = 10.d0
    else
        w1 = abs(x1-R(Rn))   * abs(y1-Z(Zn))   !/ dS
        w2 = abs(x1-R(Rn+1)) * abs(y1-Z(Zn))   !/ dS
        w3 = abs(x1-R(Rn+1)) * abs(y1-Z(Zn+1)) !/ dS
        w4 = abs(x1-R(Rn))   * abs(y1-Z(Zn+1)) !/ dS
        comp_val = (w1*reff(Rn+1,Zn+1)+w2*reff(Rn,Zn+1)+w3*reff(Rn,Zn)+w4*reff(Rn+1,Zn))/dS
        if( comp_val .gt. 5.d0 ) stop "too big complement value"
    end if
end subroutine comp_2D_scalar
! ================================================== !
end module mod_length_matrix

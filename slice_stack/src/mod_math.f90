module mod_math
implicit none

contains
! ================================================== !
subroutine check_matrix( Nlos, L, heatmapfile )
implicit none

integer, intent(in) :: Nlos
real(8), intent(in) :: L(Nlos,Nlos)
character(*) :: heatmapfile
integer :: i, j, k

    ! for heatmap
    ! open( 56,file=heatmapfile )
    !     do i = 1, Nlos
    !         do j = 1, Nlos
    !             write(56,'(2i4,198ES14.4)') i, j, L(i,j)
    !         end do
    !             write(56,*) ""
    !     end do
    ! close(56)

    ! component check
    do i = 1, Nlos
        do j = 1, Nlos
            if(L(i,j).lt.0.d0) stop "component of L < 0"
        end do
    end do

    ! check lower matrix
    k=0
    do i = 1, Nlos
        do j = 1, Nlos
            if( j <= i ) then
                if( L(i,j) == 0.d0 ) then
                    print*, "0 exists in lower triangle on line : ", i
                    k=1
                end if
            else if (j > i) then
                if( L(i,j) /= 0.d0 ) then
                    print*, "not 0 exists in upper triangle on line : ", i
                    k=1
                end if
            end if
        end do
    end do

    !print*, repeat("=",50)
    !if(k==0) print*, "Lmatnew.55 is correctly lower triangle matrix"
    if(k==1) stop "Lmatnew.55 is NOT lower triangle matrix"
    !print*, repeat("=",50)

end subroutine check_matrix
! ================================================== !
subroutine solver_lower_triangle_matrix(N, A, B, X)
implicit none
    integer, intent(in) :: N
    real(8), intent(in) :: A(N,N), B(N)
    real(8), intent(out) :: X(N)

    integer :: i,j
    real(8) :: coef

    do i = 1, N
        if (i == 1) then
            X(i) = B(i) / A(i,i)
        else
            coef = 0.d0
            do j = 1, i-1
                coef = coef + A(i,j) * X(j)
            end do
            X(i) = (B(i) - coef) / A(i,i)
        end if
    end do

end subroutine solver_lower_triangle_matrix
! ================================================== !
subroutine smoothing_signal( N, M, Y, SY )
implicit none

integer, intent(in)  :: N, M
real(8), intent(in)  :: Y(N)
real(8), intent(out) :: SY(N)

integer :: i, j, start_idx, end_idx, count
real(8) :: sum

  do i = 1, N
    start_idx = max(1, i - M/2)
    end_idx   = min(N, i + M/2)

    sum = 0.d0
    count = 0
    do j = start_idx, end_idx
      sum = sum + Y(j)
      count = count + 1
    end do

    SY(i) = sum / count
  end do

end subroutine smoothing_signal
! ================================================== !
end module mod_math
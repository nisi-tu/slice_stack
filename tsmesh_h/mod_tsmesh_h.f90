module mod_tsmesh_h
implicit none

integer, parameter :: shot = 191486
integer, parameter :: Nframe = 218

integer, parameter :: Nzr = 65

real(8) :: time(Nframe)
real(8) :: R(Nzr), Z(Nzr)
real(8) :: reff(Nframe, Nzr, Nzr)
real(8) :: theta(Nframe, Nzr, Nzr)
real(8) :: Br(Nframe, Nzr, Nzr)
real(8) :: Bz(Nframe, Nzr, Nzr)
real(8) :: Bphi(Nframe, Nzr, Nzr)

contains
! ================================================== !
subroutine rd_inpfile( inpfile )
implicit none
character(*) inpfile
real(8) :: t, rtmp, ztmp, reff_t, theta_t, Br_t, Bz_t, Bphi_t
integer :: i, j, k

    print*, ".................... ", inpfile, " ...................."

    open(101, file=inpfile, status="old", action="read")

        do i = 1, 18
            read(101,*)
        end do

        do i = 1, Nframe
            do j = 1, Nzr
                do k = 1, Nzr
                    read(101,*) t, rtmp, ztmp, reff_t, theta_t, Br_t, Bz_t, Bphi_t

                    ! reff(i, j, k) = abs(reff_t)
                    reff(i, j, k) = reff_t
                    theta(i, j, k) = theta_t
                    Br(i, j, k)    = Br_t
                    Bz(i, j, k)    = Bz_t
                    Bphi(i, j, k)  = Bphi_t

                    if (j==1 .and. k==1) time(i) = t
                    if (i==1) then
                        R(k) = rtmp
                        if (k==1) Z(j) = ztmp
                    end if

                end do
            end do
        end do
    close(101)
end subroutine rd_inpfile
! ================================================== !
subroutine op_frame( frame, filename )
implicit none

integer, intent(in) :: frame
character(*) :: filename

integer :: i, j

print*, frame, filename, time(frame)

open( 201, file=filename )

    write(201,*) "# shot  : ", shot
    write(201,*) "# frame : ", frame
    write(201,*) "# time  : ", time(frame)

    do i = 1, Nzr
        do j = 1, Nzr
            write(201,'(3ES16.6)') R(j), Z(i), reff(frame, i, j)
        end do
    end do

close(201)

end subroutine op_frame
! ================================================== !
! ================================================== !
! ================================================== !

end module mod_tsmesh_h
module mod_tsmesh_h
implicit none

integer, parameter :: Nzr = 65
real(8) :: R(Nzr), Z(Nzr), reff(Nzr,Nzr)
real(8) :: Rmin, Rmax, Zmin, Zmax
real(8) :: dr, dz, dS

contains
! ================================================== !
subroutine rd_tsmesh_h( inpf )
implicit none

character(*), intent(in) :: inpf
integer :: i, j

print*, ".................... ", inpf, " ...................."  

open(101,file=inpf,status="old", action="read")

    read(101,*)
    read(101,*)
    read(101,*)

    do i = 1, Nzr
        do j = 1, Nzr
            read(101,*) R(j), Z(i), reff(j,i)
            reff(j,i) = abs( reff(j,i) )
        end do
    end do

close(101)

Rmin = minval( R )
Rmax = maxval( R )
Zmin = minval( Z )
Zmax = maxval( Z )
dr = (Rmax-Rmin) / dble(Nzr-1)
dz = (Zmax-Zmin) / dble(Nzr-1)
dS = dr*dz

end subroutine rd_tsmesh_h
! ================================================== !
subroutine show_info_tsmesh_h

end subroutine show_info_tsmesh_h
! ================================================== !
end module mod_tsmesh_h
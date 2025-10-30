program tsmesh_h
use mod_tsmesh_h
implicit none

integer :: i, f, cc
character(32) :: opf

f = 51

call rd_inpfile( "tsmesh_h_191486.txt" )

write(opf, '("tsmesh_h_f",i2,".dat")') f
cc = 0

do i = 1, Nframe
    if( dble( int(time(i)*1000.d0) )/100.d0 == dble(f) ) then
        if(cc==1) stop "error"
        call op_frame( i, opf )
        cc = 1
    end if
end do

if(cc==0) stop "error ."

end program tsmesh_h

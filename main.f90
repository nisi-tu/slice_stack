program main_slice_stack
use mod_math
use mod_tsmesh_h
use mod_long2
use mod_length_matrix
implicit none

character(128) :: filename
integer :: i, f

f = 51

print*, "time : ", dble(f)/10.d0
print*, "total 6 of CVI and Tungsten Lines"

call rd_los( "input/los_short2.dat" )

! main
call initialize

write(filename, '("input/tsmesh_h_f",i2,".dat")') f
call rd_tsmesh_h( trim(filename) )

call set_parameters    ! set border & min_reff (for each LOS)

write(filename, '("Lmat_f",i2,".dat")') f
call line_integration_along_los( trim(filename) )

write(filename, '("heatmap_f",i2,".dat")') f
call check_matrix( Nlos, L, trim(filename) )

write(filename, '("input/intensity_f",I2,".dat")') f
call rd_line_integ_intens( trim(filename) )

do i = 1, Nline
    call smoothing_signal( Nlos, 15, LI(i,:), sLI(i,:) )
    call solver_lower_triangle_matrix( Nlos, L, sLI(i,:), emis(i,:) )
    call smoothing_signal( Nlos, 10, emis(i,:), semis(i,:) )
    emis(i,:) = semis(i,:)
    calc_LI(i,:) = matmul( L,emis(i,:) )
end do

! y-axis calibration : counts/s -->> phs m-3 /s
emis(1,:) = emis(1,:) * fcalib_short2( 26.990d0 )
emis(2,:) = emis(2,:) * fcalib_short2( 28.465d0 )
emis(3,:) = emis(3,:) * fcalib_short2( 33.737d0 )
emis(4,:) = emis(4,:) * fcalib_short2( 32.41d0 )
emis(5,:) = emis(5,:) * fcalib_short2( 30.88d0 )
emis(6,:) = emis(6,:) * fcalib_short2( 29.55d0 )
emis(:,:) = emis(:,:) / 61.21d-3    ! /61.21ms -->> /s

call op_result( f )

contains
! ================================================== !
subroutine op_result( frame )
implicit none
integer, intent(in) :: frame
integer :: i, j
character(64) :: outf

    write(outf, '("emis_f", I2, ".dat")') frame

    open(102, file=outf, status="replace")
        write(102,*) "# reff(m) emissivity of line #1~#8"
        
        do j = 1, Nlos
            write(102,*) div_reff(j), emis(1:Nline,j)
        end do
    close(102)

    write(outf , '("LIcalc_f", I2, ".dat")') f
    open(103, file=outf , status="replace")
        write(103,*) "# reff(m) reproduced integrated intensity Le"
        do j = 1, Nlos
            write(103,*) div_reff(j), calc_LI(1:Nline,j)
        end do
    close(103)

    write(outf , '("LIexp_f", I2, ".dat")') f
    open(104, file=outf , status="replace")
        write(104,*) "# reff(m) experimentally observed intensity Le"
        do j = 1, Nlos
            write(104,*) div_reff(j), LI(1:Nline,j)
        end do
    close(104)

end subroutine op_result
! ================================================== !
subroutine initialize
    L(:,:) = 0.d0
    div_reff(:) = 0.d0
    min_reff(:) = 1d10
    border(:) = -1d10

    LI(:,:)  = 0.d0
    sLI(:,:) = 0.d0
    calc_LI(:,:) = 0.d0

    emis(:,:) = 0.d0
    semis(:,:) = 0.d0
end subroutine initialize
! ================================================== !
end program main_slice_stack

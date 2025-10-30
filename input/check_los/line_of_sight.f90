program conv
implicit none

integer, parameter :: N = 204

real(8), parameter :: x1 = 2.400d0, x2 = 5.200d0
real(8)            :: z1(N), z2(N)

real(8) :: a(N), b(N)
integer            :: i, dmy

open( 101, file="../los_long2.dat", status="old", action="read" )
    do i = 1, N
        read(101,*) dmy, a(i), b(i)

    write(200+i,*) 2.3d0, a(i)*2.3d0 + b(i)
    write(200+i,*) 5.5d0, a(i)*5.5d0 + b(i)

    end do
close(101)



open( 101, file="../los_short2.dat", status="old", action="read" )
    do i = 1, N
        read(101,*) dmy, a(i), b(i)

    write(600+i,*) 2.3d0, a(i)*2.3d0 + b(i)
    write(600+i,*) 5.5d0, a(i)*5.5d0 + b(i)

    end do
close(101)

end program conv
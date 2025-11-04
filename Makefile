all:
	gfortran \
	src/mod_math.f90 \
	src/mod_tsmesh_h.f90 \
	src/mod_short2.f90 \
	src/mod_length_matrix.f90 \
	main.f90 -O2

do:
	make
	./a.out
	gnuplot plot_temp.gp
	evince graph.pdf &

clean:
	rm -f a.out *.pdf fort.* *.mod Lmatrix.dat *.gif *.dat
	rm -f Lmatnew.55


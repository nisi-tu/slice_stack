all:
	gfortran line_of_sight.f90

do:
	gfortran line_of_sight.f90
	./a.out
	gnuplot plot_temp.gp
	evince graph.pdf &
	
clean:
	rm -f fort.* los.dat a.out *.pdf

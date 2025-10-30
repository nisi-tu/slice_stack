
shot = 191486
diag = "tsmesh_h"

all:
	gfortran mod_tsmesh_h.f90 calc_tsmesh_h.f90 -O2

do:
	make
	./a.out
	#gnuplot plot_temp.gp
	#evince component_Lmat.pdf &
	#eog HOGE.gif &

clean:
	rm -f a.out *.pdf fort.* *.mod Lmatrix.dat *.gif *.dat
	rm -f Lmatnew.55

getdata:
	url="https://exp.lhd.nifs.ac.jp/opendata/LHD/webapi.fcgi?cmd=getfile&diag=${diag}&shotno=${shot}&subno=1" ; \
	outfile="$(diag)_$(shot).txt" ; \
	echo "Downloading: $$outfile" ; \
	wget -q -O "$$outfile" "$$url"

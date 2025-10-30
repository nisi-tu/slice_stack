set term pdfcairo color enh font "Computer Modern,14"
set output "graph.pdf"
set nogrid
set nokey
set size ratio 0.75
set xlabel "R (m)"
set ylabel "Z (m)"
set cblabel "r_{eff} (m)"

set pm3d map
set palette defined ( 0 '#ffffff',1 '#000fff',2 '#0090ff',3 '#0fffee',4 '#90ff70',5 '#ffee00',6 '#ff7000',7 '#ee0000',8 '#7f0000')

set xrange [2.3:5.5] ; set xtics out ; set xtics 0.5 ; set mxtics 5
set yrange [-1:1] ; set ytics out ; set ytics 0.5 ; set mytics 5
set cbrange [0:1] ; set cbtics 0.2 ; set mcbtics 2

set title "Line-of-sight of EUV Long2"
splot \
"sample_reff_2D" u 1:2:((($3)**2)**0.5) notitle,\
for [i=201:404] sprintf("fort.%d",i) u 1:2:($1-$1) w l lw 0.1 dt (2,1.8),\
for [i=201:404] sprintf("fort.%d",i) u 1:2:($1-$1) w l lw 0.1 dt (2,1.8)

set title "Line-of-sight of EUV Short2"
splot \
"sample_reff_2D" u 1:2:((($3)**2)**0.5) notitle,\
for [i=601:804] sprintf("fort.%d",i) u 1:2:($1-$1) w l lw 0.1 dt (2,1.8),\
for [i=601:804] sprintf("fort.%d",i) u 1:2:($1-$1) w l lw 0.1 dt (2,1.8)


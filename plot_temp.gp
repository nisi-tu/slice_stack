set term pdfcairo color enh font "Computer Modern,10"
set output "graph.pdf"
set size ratio 1
set nogrid
set colorsequence classic
set xlabel "r_{eff} (m)"
set ylabel "Emissivity (counts/CH/61.21ms)"

f=51
L=6

set title sprintf("LHD#191486, EUV short2, t = %d s",f/10.0)

plot [:][0:] \
sprintf("emis_f%d.dat",f) u 1:2 w l t "CVI 26.990Å",\
sprintf("emis_f%d.dat",f) u 1:3 w l t "CVI 28.465Å",\
sprintf("emis_f%d.dat",f) u 1:4 w l t "CVI 33.737Å"

plot [:][0:] \
sprintf("emis_f%d.dat",f) u 1:5 w l t "W^{24+} 32.41Å",\
sprintf("emis_f%d.dat",f) u 1:6 w l t "W^{25+} 30.88Å",\
sprintf("emis_f%d.dat",f) u 1:7 w l t "W^{26+} 29.55Å"


set ylabel "Intensity"

do for [n=1:L]{
    plot [:][0:] \
    sprintf("LIexp_f%d.dat",f)  u 1:(column(n+1)) w l t sprintf("Line #%d, exp.",n),\
    sprintf("LIcalc_f%d.dat",f) u 1:(column(n+1)) w l t sprintf("Line #%d, calc.",n)
}

reset

# set term pdfcairo color enh font "Computer Modern,14"
# set output "component_L.pdf"
# set size ratio 1
# set nogrid
# set colorsequence classic
# set pm3d map

# set xlabel "Index of Magnetic Surface"
# set ylabel "Index of Line-of-sight"
# set cblabel "Length (m)"

# set xtics out
# set ytics out

# set xrange [0:204] ; set xtics 50 ; set mxtics 5
# set yrange [204:0] ; set ytics 50 ; set mytics 5
# set cbrange [1e-3:1e0]
# set logscale cb ; set format cb "10^{%T}"

# # set pm3d interpolate 4,4

# splot sprintf("heatmap_f%d.dat",f) u 2:1:3 w pm3d notitle

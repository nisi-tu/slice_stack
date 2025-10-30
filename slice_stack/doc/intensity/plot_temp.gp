set term pngcairo color enh font "Arial,14"
set nogrid
set size ratio 0.75
set colorsequence classic

set title "#191486 EUV Short2 t=5.1s"

set output "spectrum_short2.png"
set xlabel "chord (wavelength)"
set ylabel "Intensity (a.u.)"
plot "zbin_spec_f51.dat" u 1:2 w l notitle


set xlabel "chord (space)"
set ylabel "Intensity (counts/61.21ms/ch)"

set output "intensity_CVI.png"
plot [205:0] \
"intensity_f51.dat" u 1:2 w l t "CVI 26.990Å",\
"intensity_f51.dat" u 1:3 w l t "CVI 28.465Å",\
"intensity_f51.dat" u 1:4 w l t "CVI 33.737Å"

set output "intensity_W_UTA.png"
plot [205:0] \
"intensity_f51.dat" u 1:5 w l t "W^{24+} 32.41Å",\
"intensity_f51.dat" u 1:6 w l t "W^{25+} 30.88Å",\
"intensity_f51.dat" u 1:7 w l t "W^{26+} 29.55Å"

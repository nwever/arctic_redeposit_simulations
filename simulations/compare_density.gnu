# Unicodes used for plotting:
# ⋁ (U+22C1)
# ⋀ (U+22C0)
# ⩍ (U+2A4D)
# ▬ (U+25AC)


set encoding utf8
set term pdf enhanced size 10,9.333 font 'Helvetica,18'
set datafile missing "-9999"
set output 'plots/compare_density.pdf'
set multiplot layout 4,1
set size 1,0.23
load 'plot_settings'

set cbrange[0:900]
set palette model RGB
set palette defined (150 "#FFFFCC", 200 "#C7E9B4", 250 "#7FCDBB", 300 "#41B6C4", 350 "#2C7FB8", 400 "#2C7FB8", 450 "#253494", 451 "#253494", 600 "#FFFF00")
set xtics out
set cbtics 200
set yl 'Depth (m)'
set cbl 'Bulk density (kg m^{-3})
set obj 1 rectangle from graph 0, graph 0 to graph 1, graph 1 fc rgb "white"

set title 'SNOWPACK default'
set label 100 "(a)" at graph -0.05, graph 1.12 center front tc "#000000" font "Helvetica,24"
set origin 0, 0.78
set label 90 at screen 0.5, screen .03 center "+ = precipitation particles, / = decomposing and fragmented precipitation particles,\n• = rounded grains, □ = faceted crystals, ⋀ = depth hoar, ○ melt forms, ▬ = ice formations"
pl '<(tail -n+2 postprocess/BYL_default_rho.dat | tac)' matrix with image notitle, \
'postprocess/BYL_default_gt.dat.pp' u 1:2 w p pt 1 lc rgb 'black' notitle, \
'postprocess/BYL_default_gt.dat.df' u 1:2:3 w labels font ",12" notitle, \
'postprocess/BYL_default_gt.dat.rd' u 1:2 w p pt 7 ps .5 lc rgb 'black' notitle, \
'postprocess/BYL_default_gt.dat.fc' u 1:2 w p pt 4 lc rgb 'black' notitle, \
'postprocess/BYL_default_gt.dat.dh' u 1:2:("⋀") w labels font ",12" notitle, \
'postprocess/BYL_default_gt.dat.sh' u 1:2:("⋁") w labels font ",12" notitle, \
'postprocess/BYL_default_gt.dat.mf' u 1:2 w p pt 6 lc rgb 'black' notitle, \
'postprocess/BYL_default_gt.dat.fcxr' u 1:2:("⩍") w labels font ",12" notitle, \
'postprocess/BYL_default_gt.dat.if' u 1:2:("▬") w labels font ",11" notitle
unset label 90

set title 'SNOWPACK polar'
set label 100 "(b)" at graph -0.05, graph 1.12 center front tc "#000000" font "Helvetica,24"
set origin 0, 0.535
pl '<(tail -n+2 postprocess/BYL_polar_rho.dat | tac)' matrix with image notitle, \
'postprocess/BYL_polar_gt.dat.pp' u 1:2 w p pt 1 lc rgb 'black' notitle, \
'postprocess/BYL_polar_gt.dat.df' u 1:2:3 w labels font ",12" notitle, \
'postprocess/BYL_polar_gt.dat.rd' u 1:2 w p pt 7 ps .5 lc rgb 'black' notitle, \
'postprocess/BYL_polar_gt.dat.fc' u 1:2 w p pt 4 lc rgb 'black' notitle, \
'postprocess/BYL_polar_gt.dat.dh' u 1:2:("⋀") w labels font ",12" notitle, \
'postprocess/BYL_polar_gt.dat.sh' u 1:2:("⋁") w labels font ",12" notitle, \
'postprocess/BYL_polar_gt.dat.mf' u 1:2 w p pt 6 lc rgb 'black' notitle, \
'postprocess/BYL_polar_gt.dat.fcxr' u 1:2:("⩍") w labels font ",12" notitle, \
'postprocess/BYL_polar_gt.dat.if' u 1:2:("▬") w labels font ",11" notitle

set title 'SNOWPACK redeposit mode'
set label 100 "(c)" at graph -0.05, graph 1.12 center front tc "#000000" font "Helvetica,24"
set origin 0, 0.29
pl '<(tail -n+2 postprocess/BYL_redeposit_rho.dat | tac)' matrix with image notitle, \
'postprocess/BYL_redeposit_gt.dat.pp' u 1:2 w p pt 1 lc rgb 'black' notitle, \
'postprocess/BYL_redeposit_gt.dat.df' u 1:2:3 w labels font ",12" notitle, \
'postprocess/BYL_redeposit_gt.dat.rd' u 1:2 w p pt 7 ps .5 lc rgb 'black' notitle, \
'postprocess/BYL_redeposit_gt.dat.fc' u 1:2 w p pt 4 lc rgb 'black' notitle, \
'postprocess/BYL_redeposit_gt.dat.dh' u 1:2:("⋀") w labels font ",12" notitle, \
'postprocess/BYL_redeposit_gt.dat.sh' u 1:2:("⋁") w labels font ",12" notitle, \
'postprocess/BYL_redeposit_gt.dat.mf' u 1:2 w p pt 6 lc rgb 'black' notitle, \
'postprocess/BYL_redeposit_gt.dat.fcxr' u 1:2:("⩍") w labels font ",12" notitle, \
'postprocess/BYL_redeposit_gt.dat.if' u 1:2:("▬") w labels font ",11" notitle

set title 'SNOWPACK redeposit mode with vapour transport'
set label 100 "(d)" at graph -0.05, graph 1.12 center front tc "#000000" font "Helvetica,24"
set origin 0, 0.045
pl '<(tail -n+2 postprocess/BYL_redeposit_vt_rho.dat | tac)' matrix with image notitle, \
'postprocess/BYL_redeposit_vt_gt.dat.pp' u 1:2 w p pt 1 lc rgb 'black' notitle, \
'postprocess/BYL_redeposit_vt_gt.dat.df' u 1:2:3 w labels font ",12" notitle, \
'postprocess/BYL_redeposit_vt_gt.dat.rd' u 1:2 w p pt 7 ps .5 lc rgb 'black' notitle, \
'postprocess/BYL_redeposit_vt_gt.dat.fc' u 1:2 w p pt 4 lc rgb 'black' notitle, \
'postprocess/BYL_redeposit_vt_gt.dat.dh' u 1:2:("⋀") w labels font ",12" notitle, \
'postprocess/BYL_redeposit_vt_gt.dat.sh' u 1:2:("⋁") w labels font ",12" notitle, \
'postprocess/BYL_redeposit_vt_gt.dat.mf' u 1:2 w p pt 6 lc rgb 'black' notitle, \
'postprocess/BYL_redeposit_vt_gt.dat.fcxr' u 1:2:("⩍") w labels font ",12" notitle, \
'postprocess/BYL_redeposit_vt_gt.dat.if' u 1:2:("▬") w labels font ",11" notitle

unset multiplot

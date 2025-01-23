set term pdf size 10,11.66667 font 'Helvetica,18'
set datafile missing "-9999"
set output 'plots/compare_density_avg_depth.pdf'
set multiplot layout 5,1
load 'plot_settings'
set cbrange[0:900]
set palette model RGB
set palette defined (150 "#FFFFCC", 200 "#C7E9B4", 250 "#7FCDBB", 300 "#41B6C4", 350 "#2C7FB8", 400 "#2C7FB8", 450 "#253494", 451 "#253494", 600 "#FFFF00")
set xtics out
set cbtics 200
set yl 'Depth (m)'
set cbl 'Bulk density (kg m^{-3})
set obj 1 rectangle from graph 0, graph 0 to graph 1, graph 1 fc rgb "white"

set title 'No averaging depth (only surface snow element)'
set label 100 "(a)" at graph -0.05, graph 1.12 center front tc "#000000" font "Helvetica,24"
pl '<(tail -n+2 postprocess_sensitivity_study/BYL_redeposit_ad_0.0_rho.dat | tac)' matrix with image notitle

set title 'Averaging depth = 0.05 m'
set label 100 "(b)" at graph -0.05, graph 1.12 center front tc "#000000" font "Helvetica,24"
pl '<(tail -n+2 postprocess_sensitivity_study/BYL_redeposit_ad_0.05_rho.dat | tac)' matrix with image notitle

set title 'Averaging depth = 0.1 m'
set label 100 "(c)" at graph -0.05, graph 1.12 center front tc "#000000" font "Helvetica,24"
pl '<(tail -n+2 postprocess_sensitivity_study/BYL_redeposit_ad_0.1_rho.dat | tac)' matrix with image notitle

set title 'Averaging depth = 0.15 m'
set label 100 "(c)" at graph -0.05, graph 1.12 center front tc "#000000" font "Helvetica,24"
pl '<(tail -n+2 postprocess_sensitivity_study/BYL_redeposit_ad_0.15_rho.dat | tac)' matrix with image notitle

set title 'Averaging depth = 0.2 m'
set label 100 "(c)" at graph -0.05, graph 1.12 center front tc "#000000" font "Helvetica,24"
pl '<(tail -n+2 postprocess_sensitivity_study/BYL_redeposit_ad_0.2_rho.dat | tac)' matrix with image notitle

unset multiplot

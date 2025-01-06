# This script doesn't consider possible surface hoar when plotting gt
> main_postprocess_to_exec.lst

yrange=80	# Plotting range in cm
res=0.2		# Plotting resolution in cm


for f in output/*pro
do
	g=$(basename --suffix=.pro ${f})

	# Density
	echo "gawk -F, -v yr=${yrange} -v res=${res} -v var=\"0502\" -f create_matrix.awk ${f} > postprocess/${g}_rho.dat" >> main_postprocess_to_exec.lst
done
for f in output_sensitivity_study/*pro
do
	g=$(basename --suffix=.pro ${f})

	# Density
	echo "gawk -F, -v yr=${yrange} -v res=${res} -v var=\"0502\" -f create_matrix.awk ${f} > postprocess_sensitivity_study/${g}_rho.dat" >> main_postprocess_to_exec.lst
done


# yrange in pixels
yr=$(echo ${yrange} ${res} | mawk '{print int($1/$2+0.5)}')
# determine y-axis labels, based on scaling
ylabels=$(echo ${yrange} ${res} | mawk -v yr=${yrange} -v res=${res} 'BEGIN {printf "set ytics ("} {for(i=0; i<=yr; i+=10) {if(i>0) {printf ", "}; printf "\"%.1f\" %f", (0 + i)/100, i/res}} END {printf ")\n"}')
# determine x-axis labels
xi=6	# labels every 6 months
xlabels=$(head -1 postprocess/BYL_redeposit_rho.dat | tr ' ' '\n' | awk '{printf "%02d-%02d %d\n", int(substr($1,9,2)), int(substr($1,6,2)), NR}' | awk -F- -v xi=${xi} '($1==01 && $2%xi==0)' | uniq -w5 | awk 'BEGIN {a=0; printf "set xtics ("} {if(a>0) {printf ", "} else {a=1}; printf "\"%s\" %d", $1, $2} END {printf (")\n")}' | sed 's/-01/ Jan/g' | sed 's/-02/ Feb/g' | sed 's/-03/ Mar/g' | sed 's/-04/ Apr/g' | sed 's/-05/ May/g' | sed 's/-06/ Jun/g' | sed 's/-07/ Jul/g' | sed 's/-08/ Aug/g' | sed 's/-09/ Sep/g' | sed 's/-10/ Oct/g' | sed 's/-11/ Nov/g' | sed 's/-12/ Dec/g')

# Store x and y-axis labels in a file, to be read in by gnuplot
echo ${ylabels} > plot_settings
echo ${xlabels} >> plot_settings


# Determine vertical lines
n=0
for yr in 2014 2015 2017 2018 2019
do
	let n=${n}+1
	xloc=$(head -1 postprocess/BYL_redeposit_rho.dat | tr ' ' '\n' | awk -v yr=${yr} '{if($1==sprintf("%04d-05-15T12:00", yr)) {print NR}}')
	echo "set arrow ${n} from ${xloc}, graph 0 to ${xloc}, graph 1 lc rgb 'black' lw 2 dt 2 front nohead" >> plot_settings
	echo "set label ${n} \"${yr}  \" at ${xloc}, graph 0.9 right font ',14'" >> plot_settings
done

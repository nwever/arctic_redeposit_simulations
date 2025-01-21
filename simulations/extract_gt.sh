f=$1
g=$(basename --suffix=.pro ${f})

gawk -F, -v gt=1 -f extract_gt.awk ${f} > postprocess/${g}_gt.dat.pp
gawk -F, -v gt=2 -f extract_gt.awk ${f} > postprocess/${g}_gt.dat.df
gawk -F, -v gt=3 -f extract_gt.awk ${f} > postprocess/${g}_gt.dat.rd
gawk -F, -v gt=4 -f extract_gt.awk ${f} > postprocess/${g}_gt.dat.fc
gawk -F, -v gt=5 -f extract_gt.awk ${f} > postprocess/${g}_gt.dat.dh
gawk -F, -v gt=6 -f extract_gt.awk ${f} > postprocess/${g}_gt.dat.sh
gawk -F, -v gt=7 -f extract_gt.awk ${f} > postprocess/${g}_gt.dat.sh
gawk -F, -v gt=8 -f extract_gt.awk ${f} > postprocess/${g}_gt.dat.sh
gawk -F, -v gt=9 -f extract_gt.awk ${f} > postprocess/${g}_gt.dat.sh

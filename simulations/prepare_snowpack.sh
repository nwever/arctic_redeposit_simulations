# Create required directories
mkdir -p ./input/
mkdir -p ./output/
mkdir -p ./output_sensitivity_study/
mkdir -p ./log/

# Create *sno file
function WriteSnoFile {
	echo "SMET 1.1 ASCII" > ${snofile}
	echo "[HEADER]" >> ${snofile}
	echo "station_id = ${stnid}" >> ${snofile}
	echo "station_name = ${stnname}" >> ${snofile}
	echo "latitude     = ${latitude}" >> ${snofile}
	echo "longitude    = ${longitude}" >> ${snofile}
	echo "altitude = ${altitude}" >> ${snofile}
	echo "nodata = -999" >> ${snofile}
	echo "tz = 0" >> ${snofile}
	echo "ProfileDate = ${profiledate}" >> ${snofile}
	echo "HS_Last = 0.0" >> ${snofile}
	echo "SlopeAngle = ${SlopeAngle}" >> ${snofile}
	echo "SlopeAzi = ${SlopeAzi}" >> ${snofile}
	echo "nSoilLayerData = 6" >> ${snofile}
	echo "nSnowLayerData = 0" >> ${snofile}
	echo "SoilAlbedo = 0.2" >> ${snofile}
	echo "BareSoil_z0 = 0.02" >> ${snofile}
	echo "CanopyHeight = 0" >> ${snofile}
	echo "CanopyLeafAreaIndex = 0" >> ${snofile}
	echo "CanopyDirectThroughfall = 1" >> ${snofile}
	echo "WindScalingFactor = 0" >> ${snofile}
	echo "ErosionLevel = 0" >> ${snofile}
	echo "TimeCountDeltaHS = 0" >> ${snofile}
	echo "fields = timestamp Layer_Thick T Vol_Frac_I Vol_Frac_W Vol_Frac_V Vol_Frac_S Rho_S Conduc_S HeatCapac_S rg rb dd sp mk mass_hoar ne CDot metamo" >> ${snofile}
	echo "[DATA]" >> ${snofile}

	echo "1980-10-01T01:00 1.0 281.15 0 0.25 0.125 0.625 2700 2.5 871 7.5 0 0 0 0 0 4 0 0" >> ${snofile}
	echo "1980-10-01T01:00 1.0 281.15 0 0.25 0.125 0.625 2700 2.5 871 7.5 0 0 0 0 0 5 0 0" >> ${snofile}
	echo "1980-10-01T01:00 0.6 281.15 0 0.25 0.125 0.625 2700 2.5 871 7.5 0 0 0 0 0 4 0 0" >> ${snofile}
	echo "1980-10-01T01:00 0.3 281.15 0 0.25 0.125 0.625 2700 2.5 871 7.5 0 0 0 0 0 3 0 0" >> ${snofile}
	echo "1980-10-01T01:00 0.1 281.15 0 0.25 0.125 0.625 2700 2.5 871 7.5 0 0 0 0 0 2 0 0" >> ${snofile}
	echo "1980-10-01T01:00 0.1 281.15 0 0.25 0.125 0.625 2700 2.5 871 7.5 0 0 0 0 0 5 0 0" >> ${snofile}
}

# Create ini file
function WriteIniFile {
	echo "IMPORT_BEFORE = ./io_base.ini" > ${inifile}
	echo "[INPUT]" >> ${inifile}
	echo "METEOFILE1 = ${stnid}" >> ${inifile}
}

> to_exec.lst
for smetfile in ./input/*smet
do
	stnid=$(grep -m1 station_id ${smetfile} | awk -F= '{gsub(/^[ \t]+/,"", $NF); print $NF}')
	echo Preparing SNOWPACK setup for: ${stnid}
	inifile="./iofiles/io_${stnid}.ini"
	logfile="./log/${stnid}.log"

	stnname=$(grep -m1 station_name ${smetfile} | awk -F= '{gsub(/^[ \t]+/,"", $NF); print $NF}')
	latitude=$(grep -m1 latitude ${smetfile} | awk -F= '{gsub(/^[ \t]+/,"", $NF); print $NF}')
	longitude=$(grep -m1 longitude ${smetfile} | awk -F= '{gsub(/^[ \t]+/,"", $NF); print $NF}')
	altitude=$(grep -m1 altitude ${smetfile} | awk -F= '{gsub(/^[ \t]+/,"", $NF); print $NF}')
	profiledate=$(awk '{if(/\[DATA\]/) {getline; gsub(/^[ \t]+/,"", $1); print $1; exit}}' ${smetfile})

	SlopeAngle=0
	SlopeAzi=0
	snofile="./input/${stnid}.sno"
	WriteSnoFile
	WriteIniFile

	> to_exec.lst
	for run in "default" "polar" "redeposit" "redeposit_vt"; do
		echo "IMPORT_BEFORE = ./io_${stnid}.ini" > ./iofiles/io_${stnid}_${run}.ini
		echo "IMPORT_BEFORE = ./io_${run}.ini" >> ./iofiles/io_${stnid}_${run}.ini
		echo "snowpack -c ./iofiles/io_${stnid}_${run}.ini -b ${profiledate} -e NOW > log/${stnid}_${run}.log 2>&1" >> to_exec.lst

		if [[ "${run}" == "redeposit" ]]; then
			# Setup sensitivity study
			for fetch_length in 1 2 3 5 10 20
			do
				echo "IMPORT_BEFORE = ./io_${stnid}.ini" > ./iofiles/io_${stnid}_${run}_fl_${fetch_length}.ini
				echo "IMPORT_BEFORE = ./io_${run}.ini" >> ./iofiles/io_${stnid}_${run}_fl_${fetch_length}.ini
				echo "[Output]" >> ./iofiles/io_${stnid}_${run}_fl_${fetch_length}.ini
				echo "EXPERIMENT = redeposit_fl_${fetch_length}" >> ./iofiles/io_${stnid}_${run}_fl_${fetch_length}.ini
				echo "METEOPATH = ./output_sensitivity_study" >> ./iofiles/io_${stnid}_${run}_fl_${fetch_length}.ini
				echo "[SnowpackAdvanced]" >> ./iofiles/io_${stnid}_${run}_fl_${fetch_length}.ini
				echo "SNOW_EROSION_FETCH_LENGTH = ${fetch_length}" >> ./iofiles/io_${stnid}_${run}_fl_${fetch_length}.ini
				echo "snowpack -c ./iofiles/io_${stnid}_${run}_fl_${fetch_length}.ini -b ${profiledate} -e NOW > log/${stnid}_${run}_fl_${fetch_length}.log 2>&1" >> to_exec.lst
			done
			for avg_depth in "0.0" "0.05" "0.1" "0.15" "0.2"
			do
				echo "IMPORT_BEFORE = ./io_${stnid}.ini" > ./iofiles/io_${stnid}_${run}_ad_${avg_depth}.ini
				echo "IMPORT_BEFORE = ./io_${run}.ini" >> ./iofiles/io_${stnid}_${run}_ad_${avg_depth}.ini
				echo "[Output]" >> ./iofiles/io_${stnid}_${run}_ad_${avg_depth}.ini
				echo "EXPERIMENT = redeposit_ad_${avg_depth}" >> ./iofiles/io_${stnid}_${run}_ad_${avg_depth}.ini
				echo "METEOPATH = ./output_sensitivity_study" >> ./iofiles/io_${stnid}_${run}_ad_${avg_depth}.ini
				echo "[SnowpackAdvanced]" >> ./iofiles/io_${stnid}_${run}_ad_${avg_depth}.ini
				echo "SNOW_EROSION_REDEPOSIT_AVG_DEPTH = ${avg_depth}" >> ./iofiles/io_${stnid}_${run}_ad_${avg_depth}.ini
				echo "snowpack -c ./iofiles/io_${stnid}_${run}_ad_${avg_depth}.ini -b ${profiledate} -e NOW > log/${stnid}_${run}_ad_${avg_depth}.log 2>&1" >> to_exec.lst
			done
		fi
	done
done
echo "SNOWPACK simulations have been prepared. Execute to_exec.lst to run all simulations."

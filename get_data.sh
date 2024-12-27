mkdir -p ./download/
mkdir -p ./smet/

pushd download
if [ ! -e "Bylot_driving_dataV2.csv" ]; then
    curl -o bylot.zip "https://nordicana.cen.ulaval.ca/donnees/n_45693/v601717/ds_000601795.zip"
    unzip bylot.zip Bylot_driving_dataV2.csv
    rm bylot.zip
fi
popd

stnname="Bylot_tundra"
stnid="BYL"
altitude=25
latitude="73.150400"
longitude="-80.004600"

startTime="2013-07-11T09:00"
endTime="2019-06-25T10:00"

inifile="./download/io.ini"
echo "[INPUT]" > ${inifile}
echo "COORDSYS    = UTM" >> ${inifile}
echo "COORDPARAM  = 17X" >> ${inifile}
echo "TIME_ZONE   = 0" >> ${inifile}
echo "METEO = CSV" >> ${inifile}
echo "METEOPATH = ./download/" >> ${inifile}
echo "METEOFILE1 = Bylot_driving_dataV2.csv" >> ${inifile}
echo "POSITION1 = latlon ${latitude} ${longitude} ${altitude}" >> ${inifile}
echo "CSV1_NAME = ${stnname}" >> ${inifile}
echo "CSV1_ID = ${stnid}" >> ${inifile}
echo "CSV1_COLUMNS_HEADERS = 1" >> ${inifile}
echo "CSV1_DATETIME_SPEC = DD/MM/YYYY HH24:MI" >> ${inifile}
echo "CSV1_DELIMITER  = ;" >> ${inifile}
echo "CSV1_NODATA     = -999" >> ${inifile}
echo "CSV1_FIELDS		= DATETIME VW SKIP TA RH SKIP ILWR SKIP SKIP ISWR SKIP SKIP P PSUM PSUM_RAIN PSUM_SNOW SKIP SKIP SKIP" >> ${inifile}
echo "CSV1_UNITS_OFFSET		= 0 0 0 273.15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0" >> ${inifile}
echo "CSV1_UNITS_MULTIPLIER	= 1 1 1 1      0.01 1 1 1 1 1 1 1 1000 1 1 1 1 1 1" >> ${inifile}
echo "[OUTPUT]" >> ${inifile}
echo "COORDSYS = UTM" >> ${inifile}
echo "COORDPARAM = 17X" >> ${inifile}
echo "TIME_ZONE = 0" >> ${inifile}
echo "METEO = SMET" >> ${inifile}
echo "METEOPATH = ./smet/" >> ${inifile}

meteoio_timeseries -c ./download/io.ini -b ${startTime} -e ${endTime} -s 60
rm ./download/io.ini

mkdir -p ./postprocess/
mkdir -p ./postprocess_sensitivity_study/


for d in $(cat ../download/BylotDensity201* | fgrep -i TUNDRA | awk '{printf "%04d-05-%02d\n", 2000+substr($1,8,2), substr($1,1,2)}' | uniq); do
    echo ${d}
    for profile in ./output/BYL*pro
    do
        label=$(basename ${profile} ".pro")
        bash ./tools/extract_profile.sh ${profile} "${d}T12:00" absolute > ./postprocess/${label}_${d}.txt
    done
    for profile in ./output_sensitivity_study/BYL*pro
    do
        label=$(basename ${profile} ".pro")
        bash ./tools/extract_profile.sh ${profile} "${d}T12:00" absolute > ./postprocess_sensitivity_study/${label}_${d}.txt
    done
done

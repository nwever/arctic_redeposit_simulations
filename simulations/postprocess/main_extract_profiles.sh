for d in $(cat ../../download/BylotDensity201* | fgrep TUNDRA | awk '{printf "%04d-05-%02d\n", 2000+substr($1,8,2), substr($1,1,2)}' | uniq); do
    echo ${d}
    for profile in ../output/BYL*pro
    do
        label=$(basename ${profile} ".pro")
        bash extract_profile.sh ${profile} "${d}T12:00" absolute > ${label}_${d}.txt
    done
done

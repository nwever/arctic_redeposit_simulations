bash prepare_snowpack.sh
parallel < to_exec.lst

bash main_extract_profiles.sh

bash main_postprocess.sh
parallel < main_postprocess_to_exec.lst

gnuplot compare_density.gnu
gnuplot compare_density_fetch_length.gnu

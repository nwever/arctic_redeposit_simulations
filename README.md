# Arctic tundra SNOWPACK simulations

This repository contains the workflow to run SNOWPACK for Bylot, showing how to reproduce the layering of depth hoar at the base, covered by a wind slab.

## How to reproduce

### Requirements
- Developed on Linux (Ubuntu)
- `meteoio_timeseries`, from [MeteoIO](https://meteoio.slf.ch).
- [SNOWPACK](https://github.com/snowpack-model/snowpack)
- GNU `parallel` for parallel running of simulations and postprocessing code
- `gnuplot` for plotting

### Compiling SNOWPACK
The exact SNOWPACK code used in this study is included as a git submodule. Here follow instructions for obtaining and compiling snowpack.

1. After cloning the repository, execute:<br>
`git submodule update --init --recursive`<br>
to fetch the snowpack source code.
2. Make a folder `./usr/bin/` in `./simulations/`
3. First, compile MeteoIO, following these [instructions](https://meteoio.slf.ch/Compiling-MeteoIO/). The default `cmake` options are sufficient, but set:
   - `CMAKE_INSTALL_PREFIX` to `../../../usr/bin/`
5. After compiling MeteoIO, compile SNOWPACK, following these [instructions](https://snow-models.gitlab-pages.wsl.ch/snowpack-web/Getting-started/#snowpack-from-source). In `cmake`, set:
   - `DEBUG_ARITHM` to `OFF`
   - `ENABLE_LAPACK` to `ON`. Note that this requires lapack to be installed on the system
   - `CMAKE_INSTALL_PREFIX` to `../../../usr/bin/`


### Download and convert data
- Execute `bash get_data.sh` to download and convert the meteorological data, and the measured density profiles
- Go to `simulations` folder
- Execute `bash simulation_workflow.sh`, which sets up the SNOWPACK simulations, postprocesses the simulations, and does some basic plotting

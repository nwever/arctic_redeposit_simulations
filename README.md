# Arctic tundra SNOWPACK simulations

This repository contains the workflow to run SNOWPACK for Bylot, showing how to reproduce the layering of depth hoar at the base, covered by a wind slab.

## How to reproduce

### Requirements
- Developed on Linux (Ubuntu)
- `meteoio_timeseries`, from [MeteoIO](https://meteoio.slf.ch).
- [SNOWPACK](https://github.com/snowpack-model/snowpack)
- GNU `parallel` for parallel running of simulations and postprocessing code
- `gnuplot` for plotting

### Download and convert data
- Execute `bash get_data.sh` to download and convert the meteorological data, and the measured density profiles
- Go to `simulations` folder
- Execute `bash simulation_workflow.sh`, which sets up the SNOWPACK simulations, postprocesses the simulations, and does some basic plotting

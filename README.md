<h1 id="3DGridCode"><img alt="3DGridCode" src="/media/logo.png" title="3DGridCode logo"></h1>

# 3DGridCode
3D Grid code used in PH5023 Monte Carlo Radiation Transport (MCRT) techniques @ St Andrews University

## How to run

### Using Make

First Download the code from this [link](https://github.com/lewisfish/3DGridCode/archive/refs/tags/v1.1.1.zip)

Then open a terminal and change directories to the codes location and unzip it.

Then type ```make``` into your terminal to compile the code.

Then type ```./mcgrid``` to run the code.

### Using FPM

First Download the code from this [link](https://github.com/lewisfish/3DGridCode/archive/refs/tags/v1.1.1.zip)

Then open a terminal and change directories to the codes location and unzip it.

Then type ```fpm run --profile release``` to compile and run the code.

Details on installing FPM on your platform can be found [here](https://fpm.fortran-lang.org/install/index.html#install).

## Documentation

Documentation of the API can be found [here](http://lewismcmillan.com/3DGridCode/).

Explanation of the code and the MCRT method can be found [here](http://www-star.st-and.ac.uk/~kw25/teaching/mcrt/mcrt.html).

## Make & GFortran 

Check version, or whether installed, by opening terminal and typing ```make --version``` and ```gfortran --version```

For Make:

Mac: Install the xcode developer tools, found [here](https://developer.apple.com/xcode/). If make is still not installed, open terminal and type ```xcode-select - - install```. 

Linux (Debian): Open a terminal and install by typing ```sudo apt-get install build-essential```. 

For GFortran 
 
Mac: Details [here](https://gcc.gnu.org/wiki/GFortranBinaries#MacOS). [Homebrew](https://brew.sh) offers an easy install via ```brew install gcc```, or get binaries directly from the gfortran maintainers [here](https://github.com/fxcoudert/gfortran-for-macOS/releases).

Linux (Debian): Open a terminal and install by typing ```sudo apt install gfortran```.

More details on GFortran [here](https://fortran-lang.org/learn/os_setup/install_gfortran/)); other fortran compilers are available. 

## References

Code was adapted and heavily modified from K. Woods code found [here](http://www-star.st-and.ac.uk/~kw25/research/montecarlo/points/points.html).

This code (3DGridCode) formed the basis of the following research projects:

[Depth Penetration of Light into Skin as a Function of Wavelength from 200 to 1000 nm](https://doi.org/10.1111/php.13550)

[Development of a Predictive Monte Carlo Radiative Transfer Model for Ablative Fractional Skin Lasers](https://doi.org/10.1002/lsm.23335)

[Imaging in thick samples, a phased Monte Carlo radiation transfer algorithm](https://doi.org/10.1117/1.JBO.26.9.096004)

[Simulation of Intraoperative PDT for Glioblastoma using Monte Carlo Radiative Transport](https://www.researchgate.net/profile/Louise_Finlayson2/publication/364330477_Simulation_of_Intraoperative_PDT_for_Glioblastoma_using_Monte_Carlo_Radiative_Transport/links/6349849c2752e45ef6b7c525/Simulation-of-Intraoperative-PDT-for-Glioblastoma-using-Monte-Carlo-Radiative-Transport.pdf)

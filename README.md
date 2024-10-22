<h1 id="3DGridCode"><img alt="3DGridCode" src="/media/logo.png" title="3DGridCode logo"></h1>

# 3DGridCode
3D Grid code used in PH5023 Monte Carlo Radiation Transport (MCRT) techniques @ St Andrews University

## How to run

### Using Jupyter Lab and Make

Either:

- Open a Terminal and run this command:
  
  ```wget https://github.com/lewisfish/3DGridCode/archive/refs/tags/3DGridCode.zip```

or:

- Download the code from this [link](https://github.com/lewisfish/3DGridCode/archive/refs/tags/3DGridCode.zip) and upload it to Jupyter Lab.

Note if you've not used a Terminal before or need a refresher this [link](https://ubuntu.com/tutorials/command-line-for-beginners#1-overview) provides a nice intorduction to the Terminal basics.

The next step is to open a Terminal (if not already open) and change directory (```cd dir``` where dir is the directory to change to) to the codes location and unzip it (```unzip 3DGridCode.zip```)

Next change directory into the unzip folder and type ```make``` into your terminal to compile the code.

Finally to run the code, type ```./mcgrid```.
Each time you make a change to the code, you need to recompile then run the code (```make``` then ```./mcgrid```).

### Using Fortran Package Manager (FPM)

First Download the code from this [link](wget https://github.com/lewisfish/3DGridCode/archive/refs/tags/3DGridCode.zip)

Then open a terminal and change directories to the codes location and unzip it.

Then type ```fpm run --profile release``` to compile and run the code.

Details on installing FPM on your platform can be found [here](https://fpm.fortran-lang.org/install/index.html#install).

## Installing Make & GFortran 

Check version, or whether installed, by opening terminal and typing ```make --version``` and ```gfortran --version```

### Make

Mac: Install the xcode developer tools, found [here](https://developer.apple.com/xcode/). If make is still not installed, open terminal and type ```xcode-select - - install```. 

Linux (Debian): Open a terminal and install by typing ```sudo apt-get install build-essential```. 

### GFortran 
 
Mac: [Homebrew](https://brew.sh) offers an easy install via ```brew install gcc```. The binaries can be installed directly from the [gfortran maintainers](https://github.com/fxcoudert/gfortran-for-macOS/releases), and additional info can be found [here](https://gcc.gnu.org/wiki/GFortranBinaries#MacOS).

Linux (Debian): Open a terminal and install by typing ```sudo apt install gfortran```.

More details on GFortran may be found [here](https://fortran-lang.org/learn/os_setup/install_gfortran/). 

### Windows

Fortran can also be used on Windows, we recommend using the Windows subsytem for Linux (WSL), more information on this [here](https://learn.microsoft.com/en-us/windows/wsl/install).
Other ways of installing Fortran can be found [here](https://fortran-lang.org/learn/os_setup/install_gfortran/#windows).

## References

Code was adapted and heavily modified from K. Woods code found [here](http://www-star.st-and.ac.uk/~kw25/research/montecarlo/points/points.html).

This code (3DGridCode) formed the basis of the following research projects:

[Depth Penetration of Light into Skin as a Function of Wavelength from 200 to 1000 nm](https://doi.org/10.1111/php.13550)

[Development of a Predictive Monte Carlo Radiative Transfer Model for Ablative Fractional Skin Lasers](https://doi.org/10.1002/lsm.23335)

[Imaging in thick samples, a phased Monte Carlo radiation transfer algorithm](https://doi.org/10.1117/1.JBO.26.9.096004)

[Simulation of Intraoperative PDT for Glioblastoma using Monte Carlo Radiative Transport](https://www.researchgate.net/profile/Louise_Finlayson2/publication/364330477_Simulation_of_Intraoperative_PDT_for_Glioblastoma_using_Monte_Carlo_Radiative_Transport/links/6349849c2752e45ef6b7c525/Simulation-of-Intraoperative-PDT-for-Glioblastoma-using-Monte-Carlo-Radiative-Transport.pdf)


License
-------

The gridMCRT source code and related files and documentation are distributed under a permissive free software license (MIT).

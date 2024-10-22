---
project: gridMCRT
src_dir: ./src
output_dir: ./docs
summary: ![3DGridCode](https://raw.githubusercontent.com/lewisfish/3DGridCode/refs/heads/main/media/logo.png)<br> Monte Carlo radiation transfer (MCRT) on a 3D grid.
author: Lewis McMillan, Kenny Wood, Isla Barnard
media_dir: media
favicon: ./media/favicon-32x32.png
predocmark_alt: >
predocmark: <
display: public
         protected
         private
source: true
graph: true
search: true
sort: alpha
extra_mods: iso_fortran_env:https://gcc.gnu.org/onlinedocs/gfortran/ISO_005fFORTRAN_005fENV.html
md_extensions: markdown.extensions.toc
exclude_dir: ./.github
---

--------------------
[TOC]

Brief description
-----------------

A Monte Carlo radiation transfer (MCRT) code with voxels representing the geometry, written in modern Fortran.
The code is setup to run a MCRT simulation in a sphere, radius 1cm, with isotropic scattering properties and an albedo of 1.
Photons are released isotropically from the center of the sphere. The output should give the average number of scatterings as ~57. 

You can browse the structure of the code using the tabs at the top of the page for more information on how the code is structured.
The input file, res/input.params, sets the input parameters of the simulation.

Original code was by K. Wood. Current version was heavily modified converted to modern Fortran by L. McMillan.


# How to run
----------

### Using Jupyter Lab and Make

Either:

- Open a Terminal and run this command:
  ```wget https://github.com/lewisfish/3DGridCode/archive/refs/tags/v1.2.zip -O 3DGridCode```

or:

- Download the code from this [link](https://github.com/lewisfish/3DGridCode/archive/refs/tags/v1.2.zip) and upload it to Jupyter Lab.

Note if you've not used a Terminal before or need a refresher this [link](https://ubuntu.com/tutorials/command-line-for-beginners#1-overview) provides a nice intorduction to the Terminal basics.

The next step is to open a Terminal (if not already open) and change directory (```cd dir``` where dir is the directory to change to) to the codes location and unzip it (```unzip 3DGridCode``` or ```unzip v1.2.zip```)

Next change directory into the unzip folder and type ```make``` into your terminal to compile the code.

Finally to run the code, type ```./mcgrid```.

### Using Fortran Package Manager (FPM)

First Download the code from this [link](https://github.com/lewisfish/3DGridCode/archive/refs/tags/v1.2.zip)

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

---
project: gridMCRT
src_dir: ./src
output_dir: ./docs
summary: ![3DGridCode](|media|/logo.png)<br> Monte Carlo radiation transfer (MCRT) on a 3D grid.
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

License
-------

The gridMCRT source code and related files and documentation are distributed under a permissive free software license (MIT).
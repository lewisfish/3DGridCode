---
project: gridMCRT
src_dir: ./src
output_dir: ./docs
summary: Monte Carlo radiation transfer (MCRT) on a 3D grid.
author: Lewis McMillan
github: https://github.com/lewisfish
predocmark_alt: >
predocmark: <
docmark_alt:
display: public
         protected
source: true
graph: true
search: true
sort: alpha
fpp_extensions: fpp
preprocess: true
extra_mods: iso_fortran_env:https://gcc.gnu.org/onlinedocs/gfortran/ISO_005fFORTRAN_005fENV.html
md_extensions: markdown.extensions.toc
               markdown.extensions.tables
               markdown_checklist.extension
---

--------------------
[TOC]

Brief description
-----------------

A Monte Carlo radiation transfer code with voxels representing the geometry, written in modern Fortran.

License
-------

The gridMCRT source code and related files and documentation are distributed under a permissive free software license (MIT).

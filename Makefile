# cobbled together from https://stackoverflow.com/questions/1950926/create-directories-using-make-file
# and https://stackoverflow.com/a/30602701/6106938
# and https://github.com/lewisfish/pMC/blob/master/src/Makefile
FCOMP := gfortran
FCFLAGS := -O2 -march=native -flto
FCDEBUG := -g -fbacktrace -fcheck=all -fbounds-check -ffpe-trap=invalid,overflow,underflow,denormal
FCBUILD := -Wall -Wextra -pedantic -std=f2008

SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := .
DATA_DIR := data/jmean
FCFLAGS += -J$(OBJ_DIR)

.SUFFIXES:
.SUFFIXES: .f90 .o .mod

EXE := $(BIN_DIR)/mcgrid
SRC =       $(SRC_DIR)/constants.f90 \
      	$(SRC_DIR)/random_mod.f90 \
		$(SRC_DIR)/utils.f90 \
            $(SRC_DIR)/vector_class.f90 \
            $(SRC_DIR)/optical_properties.f90 \
            $(SRC_DIR)/photon_class.f90 \
            $(SRC_DIR)/iarray.f90 \
            $(SRC_DIR)/gridset.f90 \
            $(SRC_DIR)/inttau2.f90 \
            $(SRC_DIR)/sourceph.f90 \
            $(SRC_DIR)/writer.f90 \
            $(SRC_DIR)/mcpolar.f90
            
OBJ := $(SRC:$(SRC_DIR)/%.f90=$(OBJ_DIR)/%.o)

.PHONY: all debug build clean

all: $(EXE) directories
directories: $(DATA_DIR)
debug: FCFLAGS += $(FCDEBUG)
debug: $(EXE)
build: FCFLAGS += $(FCBUILD)
build: $(EXE) 

$(EXE): $(OBJ) | $(BIN_DIR)
	$(FCOMP) $(FCFLAGS) -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.f90 | $(OBJ_DIR)
	$(FCOMP) $(FCFLAGS) -c $< -o $@

$(OBJ_DIR):
	mkdir -p $@

$(DATA_DIR):
	mkdir -p $@

clean:
	@$(RM) -rv $(OBJ_DIR) mcgrid # The @ disables the echoing of the command

# OS X installed with ports
SCADPATH = /Applications/MacPorts/OpenSCAD.app/Contents/MacOS/OpenSCAD

# OS X downloaded
#SCADPATH = /Applications/MacPorts/OpenSCAD.app/Contents/MacOS/OpenSCAD

# *nix installed in path
#SCADPATH = openscad

INCLUDES = $(wild src/includes/*.scad)
MODELS = $(patsubst src/%,%,$(wildcard src/*.scad))

STL_FILES_1 = $(foreach src, $(MODELS),output/$(src))
STL_FILES = $(STL_FILES_1:%.scad=%.stl)

all: $(STL_FILES)

output/%.stl: src/%.scad $(INCLUDES) configuration.scad
	$(SCADPATH) -o $@ $<

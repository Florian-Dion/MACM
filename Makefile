# Compiler and flags
GHDL := ghdl
GHDL_FLAGS := --ieee=synopsys --std=08

# Source files
SOURCES := your_source_file.vhd

# Executable name
EXECUTABLE := your_executable_name

# Targets
all: $(EXECUTABLE)

$(EXECUTABLE): $(SOURCES)
	$(GHDL) -e $(GHDL_FLAGS) $(EXECUTABLE)
	$(GHDL) -r $(GHDL_FLAGS) $(EXECUTABLE) --wave=$(EXECUTABLE).ghw
	gtkwave $(EXECUTABLE).ghw

clean:
	rm -f $(EXECUTABLE) $(EXECUTABLE).ghw
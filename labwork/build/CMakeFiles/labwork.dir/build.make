# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.7

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/vund/advancedhpc2017/labwork

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/vund/advancedhpc2017/labwork/build

# Include any dependencies generated for this target.
include CMakeFiles/labwork.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/labwork.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/labwork.dir/flags.make

CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o: CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o.depend
CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o: CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o.cmake
CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o: ../src/jpegloader.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/vund/advancedhpc2017/labwork/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building NVCC (Device) object CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o"
	cd /home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src && /usr/bin/cmake -E make_directory /home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/.
	cd /home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src && /usr/bin/cmake -D verbose:BOOL=$(VERBOSE) -D build_configuration:STRING= -D generated_file:STRING=/home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/./labwork_generated_jpegloader.cu.o -D generated_cubin_file:STRING=/home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/./labwork_generated_jpegloader.cu.o.cubin.txt -P /home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o.cmake

CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o: CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o.depend
CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o: CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o.cmake
CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o: ../src/labwork.cu
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/vund/advancedhpc2017/labwork/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building NVCC (Device) object CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o"
	cd /home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src && /usr/bin/cmake -E make_directory /home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/.
	cd /home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src && /usr/bin/cmake -D verbose:BOOL=$(VERBOSE) -D build_configuration:STRING= -D generated_file:STRING=/home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/./labwork_generated_labwork.cu.o -D generated_cubin_file:STRING=/home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/./labwork_generated_labwork.cu.o.cubin.txt -P /home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o.cmake

CMakeFiles/labwork.dir/src/timer.cpp.o: CMakeFiles/labwork.dir/flags.make
CMakeFiles/labwork.dir/src/timer.cpp.o: ../src/timer.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/vund/advancedhpc2017/labwork/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/labwork.dir/src/timer.cpp.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/labwork.dir/src/timer.cpp.o -c /home/vund/advancedhpc2017/labwork/src/timer.cpp

CMakeFiles/labwork.dir/src/timer.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/labwork.dir/src/timer.cpp.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/vund/advancedhpc2017/labwork/src/timer.cpp > CMakeFiles/labwork.dir/src/timer.cpp.i

CMakeFiles/labwork.dir/src/timer.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/labwork.dir/src/timer.cpp.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/vund/advancedhpc2017/labwork/src/timer.cpp -o CMakeFiles/labwork.dir/src/timer.cpp.s

CMakeFiles/labwork.dir/src/timer.cpp.o.requires:

.PHONY : CMakeFiles/labwork.dir/src/timer.cpp.o.requires

CMakeFiles/labwork.dir/src/timer.cpp.o.provides: CMakeFiles/labwork.dir/src/timer.cpp.o.requires
	$(MAKE) -f CMakeFiles/labwork.dir/build.make CMakeFiles/labwork.dir/src/timer.cpp.o.provides.build
.PHONY : CMakeFiles/labwork.dir/src/timer.cpp.o.provides

CMakeFiles/labwork.dir/src/timer.cpp.o.provides.build: CMakeFiles/labwork.dir/src/timer.cpp.o


# Object files for target labwork
labwork_OBJECTS = \
"CMakeFiles/labwork.dir/src/timer.cpp.o"

# External object files for target labwork
labwork_EXTERNAL_OBJECTS = \
"/home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o" \
"/home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o"

labwork: CMakeFiles/labwork.dir/src/timer.cpp.o
labwork: CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o
labwork: CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o
labwork: CMakeFiles/labwork.dir/build.make
labwork: /usr/local/cuda/lib64/libcudart_static.a
labwork: /usr/lib/x86_64-linux-gnu/librt.so
labwork: /usr/lib/x86_64-linux-gnu/libjpeg.so
labwork: CMakeFiles/labwork.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/vund/advancedhpc2017/labwork/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking CXX executable labwork"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/labwork.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/labwork.dir/build: labwork

.PHONY : CMakeFiles/labwork.dir/build

CMakeFiles/labwork.dir/requires: CMakeFiles/labwork.dir/src/timer.cpp.o.requires

.PHONY : CMakeFiles/labwork.dir/requires

CMakeFiles/labwork.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/labwork.dir/cmake_clean.cmake
.PHONY : CMakeFiles/labwork.dir/clean

CMakeFiles/labwork.dir/depend: CMakeFiles/labwork.dir/src/labwork_generated_jpegloader.cu.o
CMakeFiles/labwork.dir/depend: CMakeFiles/labwork.dir/src/labwork_generated_labwork.cu.o
	cd /home/vund/advancedhpc2017/labwork/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/vund/advancedhpc2017/labwork /home/vund/advancedhpc2017/labwork /home/vund/advancedhpc2017/labwork/build /home/vund/advancedhpc2017/labwork/build /home/vund/advancedhpc2017/labwork/build/CMakeFiles/labwork.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/labwork.dir/depend


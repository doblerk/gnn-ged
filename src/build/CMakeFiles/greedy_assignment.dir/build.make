# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
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
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/dobleraemon/Documents/PhD/gnn-ged/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/dobleraemon/Documents/PhD/gnn-ged/src/build

# Include any dependencies generated for this target.
include CMakeFiles/greedy_assignment.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/greedy_assignment.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/greedy_assignment.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/greedy_assignment.dir/flags.make

CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.o: CMakeFiles/greedy_assignment.dir/flags.make
CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.o: ../calc_greedy_assignment.cpp
CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.o: CMakeFiles/greedy_assignment.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dobleraemon/Documents/PhD/gnn-ged/src/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.o -MF CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.o.d -o CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.o -c /home/dobleraemon/Documents/PhD/gnn-ged/src/calc_greedy_assignment.cpp

CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/dobleraemon/Documents/PhD/gnn-ged/src/calc_greedy_assignment.cpp > CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.i

CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/dobleraemon/Documents/PhD/gnn-ged/src/calc_greedy_assignment.cpp -o CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.s

# Object files for target greedy_assignment
greedy_assignment_OBJECTS = \
"CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.o"

# External object files for target greedy_assignment
greedy_assignment_EXTERNAL_OBJECTS =

greedy_assignment.cpython-310-x86_64-linux-gnu.so: CMakeFiles/greedy_assignment.dir/calc_greedy_assignment.cpp.o
greedy_assignment.cpython-310-x86_64-linux-gnu.so: CMakeFiles/greedy_assignment.dir/build.make
greedy_assignment.cpython-310-x86_64-linux-gnu.so: CMakeFiles/greedy_assignment.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/dobleraemon/Documents/PhD/gnn-ged/src/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared module greedy_assignment.cpython-310-x86_64-linux-gnu.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/greedy_assignment.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/greedy_assignment.dir/build: greedy_assignment.cpython-310-x86_64-linux-gnu.so
.PHONY : CMakeFiles/greedy_assignment.dir/build

CMakeFiles/greedy_assignment.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/greedy_assignment.dir/cmake_clean.cmake
.PHONY : CMakeFiles/greedy_assignment.dir/clean

CMakeFiles/greedy_assignment.dir/depend:
	cd /home/dobleraemon/Documents/PhD/gnn-ged/src/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/dobleraemon/Documents/PhD/gnn-ged/src /home/dobleraemon/Documents/PhD/gnn-ged/src /home/dobleraemon/Documents/PhD/gnn-ged/src/build /home/dobleraemon/Documents/PhD/gnn-ged/src/build /home/dobleraemon/Documents/PhD/gnn-ged/src/build/CMakeFiles/greedy_assignment.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/greedy_assignment.dir/depend


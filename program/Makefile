TARGET_EXEC := program

BUILD_DIR := ./obj
SRC_DIRS := ./src

# Find all the C and C++ files we want to compile
SRCS := $(shell find $(SRC_DIRS) -name '*.cpp' -or -name '*.c' | grep -o '[^/]*\.cpp')
SRCS += glad.c

# String substitution for every C/C++ file.
# As an example, hello.cpp turns into ./build/hello.cpp.o
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

# String substitution (suffix version without %).
# As an example, ./build/hello.cpp.o turns into ./build/hello.cpp.d
DEPS := $(OBJS:.o=.d)

# Every folder in ./src will need to be passed to GCC so that it can find header files
INC_DIRS := $(shell find $(SRC_DIRS) -type d)
# Add a prefix to INC_DIRS. So moduleA would become -ImoduleA. GCC understands this -I flag
INC_FLAGS := $(addprefix -I,$(INC_DIRS))
LDFLAGS := -W -Wall -Werror -lglfw -lGL -ldl -I./include

# The -MMD and -MP flags together generate Makefiles for us!
# These files will have .d instead of .o as the output.
CPPFLAGS := $(INC_FLAGS) -g
CXXFLAGS := -std=c++11


all: shader execute

# Check and upgrade dependencies
install:
	sudo apt-get update
	sudo apt-get upgrade gcc g++ flex libglapi-mesa mesa-utils mesa-common-dev libglfw3 libglfw3-dev
	tar -zxvf bison-3.5.tar.gz
	cd bison-3.5 && ./configure && $(MAKE) && sudo $(MAKE) install
	rm -rf bison-3.5
	$(MAKE) shader
	$(MAKE) bin/$(TARGET_EXEC)
	
execute: bin/$(TARGET_EXEC)
	./bin/$(TARGET_EXEC)

# The final build step.
bin/$(TARGET_EXEC): $(OBJS)
	echo $(SRCS)
	mkdir -p bin
	$(CXX) $(OBJS) -o $@ $(LDFLAGS)


# Build step for C source
$(BUILD_DIR)/%.c.o: src/%.c
	mkdir -p $(dir $@)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@ -I./include

# Build step for C++ source
$(BUILD_DIR)/%.cpp.o: src/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@ -I./include

shader: manifolds/lastParam.in
	cd ./processor/ && $(MAKE) all
	cd ..

clean:
	rm -rf bin/* obj/* imgui.ini
	cd ./processor/ && $(MAKE) clean
	cd ..

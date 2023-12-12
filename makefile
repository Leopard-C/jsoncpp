#
# (1)x86_64
#   make
#
# (2)aarch64
#   make CXX=aarch64-linux-gnu-g++ AR=aarch64-linux-gnu-ar ARCH=aarch64
#
CXX  ?= g++
AR   ?= ar
ARCH ?= $(shell uname -m)

BUILDIR = build/linux/$(ARCH)
LIBDIR  = lib/linux/$(ARCH)
FLAGS = --std=c++11 -O3

all: bin/example.out $(LIBDIR)/libjsoncpp.a

bin/example.out: example/main.cpp $(LIBDIR)/libjsoncpp.a
	$(CXX) -I./include $(FLAGS) -o $@ example/main.cpp -L$(LIBDIR) -ljsoncpp

$(LIBDIR)/libjsoncpp.a: $(BUILDIR)/json_reader.o $(BUILDIR)/json_writer.o $(BUILDIR)/json_value.o
	$(AR) crv $@ $^

$(BUILDIR)/%.o: src/lib_json/%.cpp
	$(shell if [ ! -e bin ]; then mkdir bin; fi)
	$(shell if [ ! -e "$(BUILDIR)" ]; then mkdir -p "$(BUILDIR)"; fi)
	$(shell if [ ! -e "$(LIBDIR)"  ]; then mkdir -p "$(LIBDIR)"; fi)
	$(CXX) -I./include $(FLAGS) -o $@ -c $<

.PHONY: clean
clean:
	-rm -rf bin build lib

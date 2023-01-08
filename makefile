
$(shell if [ ! -e bin ]; then mkdir bin; fi)
$(shell if [ ! -e build ]; then mkdir build; fi)
$(shell if [ ! -e lib/linux ]; then mkdir -p lib/linux; fi)

FLAGS = -O0 -g

all: bin/example.out lib/linux/libjsoncpp.a

bin/example.out: example/main.cpp lib/linux/libjsoncpp.a
	g++ -I./include -I./include/jsoncpp $(FLAGS) -o $@ example/main.cpp -L./lib/linux -ljsoncpp

lib/linux/libjsoncpp.a: build/json_reader.o build/json_writer.o build/json_value.o
	ar crv $@ $^

build/%.o: src/lib_json/%.cpp
	g++ -I./include/jsoncpp $(FLAGS) -o $@ -c $<

.PHONY: clean
clean:
	-rm -rf bin build lib/linux/libjsoncpp.a

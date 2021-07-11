CXX        = g++
#CXXFLAGS   = -std=c++17 -Wall -Wextra -O0 -g
CXXFLAGS   = -std=c++17 -Wall -Wextra -O2
LDFLAGS    = -pthread
TARGET     = rate_limiter

all: init clean link end
init:
	$(info * [Starting build])

link: test/test.o src/rate_limiter.o
	$(info * [Linking $^])
	$(CXX) $(LDFLAGS) $(CXXFLAGS) $^ -o $(TARGET)

src/rate_limiter.o: src/rate_limiter.cpp
	$(info * [Creating $@ from $<])
	$(CXX) $(CXXFLAGS) -c $< -o src/rate_limiter.o

test/test.o: test/test.cpp
	$(info * [Creating $@ from $<])
	$(CXX) $(CXXFLAGS) -I./src -c $< -o test/test.o
clean:
	$(info * [Cleaning old build])
	rm -f src/*.o test/*.o $(TARGET)
end:
	$(info * [Build successful. $(TARGET) was created])
.PHONY: all init clean link end
#.SILENT:

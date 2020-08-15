FC = gfortran
FCFLAGS = -O

SRCS := $(eval SRCS := $(shell find ./src -type f -name "*.f90"))$(SRCS)
OBJS = $(SRCS:%.f90=%.o)

TARGET_BIN = xorshift_demo

LDFLAGS =

SHELL = bash

.PHONY: all
all: \
	clean \
	$(TARGET_BIN)

.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET_BIN)

$(TARGET_BIN): $(OBJS)
	$(FC) -o $@ $(LDFLAGS) $^

$(OBJS): $(SRCS)
	$(FC) -c $*.f90 -o $@ $(FCFLAGS)

src/xorshift/xorshift.o: src/xorshift/xorshift.f90


# The integer number in this Makefile is I4, 
# please uncomment this line in WHAM.py
# from numpy import int32 as intpy

.DEFAULT: .f .for .c .C .cpp .cc
.SUFFIXES: .f .for .c .C .cpp .cc

O = .

F77 = gfortran
CC = gcc
CCC = g++ 

CFLAGS = -fPIC -O0 -g -I/home/aadcroft/.conda/envs/subgrid38/include/python3.8 \
       -I/home/aadcroft/.conda/envs/subgrid38/lib/python3.8/site-packages/numpy/core/include \
        -DNPY_NO_DEPRECATED_API=NPY_1_7_API_VERSION

FFLAGS = -fPIC -O0 -g

LIBS = -L/home/aadcroft/.conda/envs/subgrid38/lib -lpython3.8 -lstdc++
Link = $(F77) $(CFLAGS)

EXENAME = main.exe

OBJS =  $(O)/main.o  $(O)/runpy.o $(O)/pyext.o  $(O)/linend.o

$(EXENAME) : $(OBJS) 
	$(Link) -o $(EXENAME) $(OBJS) $(LIBS)

run: $(EXENAME)
	LD_LIBRARY_PATH=/home/aadcroft/.conda/envs/subgrid38/lib/ ./$(EXENAME)

$(O)/%.o: %.c
	cd $(O) ; $(CC)  $(CFLAGS) -c $<
$(O)/%.o: %.cc
	cd $(O) ; $(CCC) $(CFLAGS) -c $<
$(O)/%.o: %.cpp
	cd $(O) ; $(CCC) $(CFLAGS) -c $<
$(O)/%.o: %.C
	cd $(O) ; $(CCC) $(CFLAGS) -c $<
$(O)/%.o: %.F
	cd $(O) ; $(F77) $(FFLAGS) -c $<
$(O)/%.o: %.for
	cd $(O) ; $(F77) $(FFLAGS) -c $<

clean:
	rm -f core *.o *.so
dat: 
	rm -f *.dat
backup:
	rm -f *~
clobber:
	rm -f $(EXENAME).exe
cleanall:
	rm -f *.o *.dat *~ *.exe *.exe.* $(EXENAME) *.pyc

.PRECIOUS: %_wrap.C %.C %.c %.f %.h $(O)/%.o

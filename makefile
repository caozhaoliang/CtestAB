#.PHONY default all  BINFILE
BINFILE := ./testAb

LIBS := stdc++  m  pthread 

INCS :=	 ./sem/ ./pthreadPool/

LIBPATHS := /usr/lib /usr/local/lib

USER_MARCOS := 
test=0
ifeq ($(test), 1)
USER_MARCOS := $(USER_MARCOS) _TEST_ 
endif

CFLAGS = -g -Wall -pg  -O2 -Wno-deprecated 
CC = g++ 

COMMONSRCS=$(wildcard ./pthreadPool/*.cpp ./sem/*.cpp ./src/*.cpp)


COMMONOBJS=$(patsubst %.cpp,%.o,$(COMMONSRCS))

all:$(BINFILE)

$(BINFILE): $(OBJS) $(COMMONOBJS)
	$(CC) $(CFLAGS) -o $@ $^   $(addprefix -L,$(LIBPATHS)) $(addprefix -l,$(LIBS)) 
  
%.o:%.cpp
	$(CC) $(CFLAGS) $(addprefix -D,$(USER_MARCOS)) $(addprefix -I,$(INCS)) -c $< -o $@

install :
	

clean :  
	rm -rf $(COMMONOBJS)  $(BINFILE) 

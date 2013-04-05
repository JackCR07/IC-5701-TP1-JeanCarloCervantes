# Compilacion predeterminada
COMPILER = scxt
PRODUCTS = $(COMPILER) 
default: $(PRODUCTS)

# Lista de archivos fuente
SRCS = main.c

OBJS = lex.yy.o $(patsubst %.cc, %.o, $(filter %.cc,$(SRCS))) $(patsubst %.c, %.o, $(filter %.c, $(SRCS)))

# para definir los archivos intermedios basura, para hacer clean
JUNK =  *.o lex.yy.c dpp.yy.c y.tab.c y.tab.h *.core core

# Herramientas usadas en la compilacion
CC= gcc
LD = gcc
LEX = flex

# Apagar los warnings innecesarios
CFLAGS = -g -Wall -Wno-unused -Wno-sign-compare

# Se activa el debugging de flex
LEXFLAGS = -d

# link con las librerias de c, mate y lex, respectivamente
LIBS = -lc -lm -ll 

# Reglas para productos intermedios
.yy.o: $*.yy.c
	$(CC) $(CFLAGS) -c -o $@ $*.cc

lex.yy.c: xhtmlscanner.l 
	$(LEX) $(LEXFLAGS) scanner.l

.cc.o: $*.cc
	$(CC) $(CFLAGS) -c -o $@ $*.cc

# Reglas para compilar
$(COMPILER) : $(OBJS)
	$(LD) -o $@ $(OBJS) $(LIBS)

# make depend se encarga de configurar los headers de dependencias,
# agrega la lista de dependencias al final del makefile. Si se agregan
# nuevos headers, se debe hacer make depend.
depend:
	makedepend -- $(CFLAGS) -- $(SRCS)

clean:
	rm -f $(JUNK) y.output $(PRODUCTS)


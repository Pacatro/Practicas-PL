# Si se desea generar ejemplo7.exe entonces teclear 
#  make
#
# Si se desea generar otro "ejemplo" entonces teclear 
#            make NAME=ejemplo

NAME = figura

# Directives for the compiler
# -c: the output is an object file, the linking stage is not done.
# -g: debug
# -Wall: all warnings
# -ansi: standard language
# -02: optimization level
# -Wno-unused-function  -Wno-sign-compare -Wno-implicit-function-declaration: disabled error messages
CFLAGS = -c -g -Wall -ansi -O2 -Wno-unused-function  -Wno-sign-compare -Wno-implicit-function-declaration

# Directive for flex's library
LFLAGS = -lfl 

# Predefined macros 
#
# $@: name of the target
# $^: all the dependencies
# $<: first dependency
#
################################################################

##
# MODIFICADO
$(NAME).exe: $(NAME).o auxiliar.o
	@echo "Generating" $@
	@gcc $^ $(LFLAGS) -o $@ -lm

# NUEVO
main.o: main.c token.h
	@echo "Compiling" $<" and generating" $@
	@gcc $(CFLAGS) $< -o $@ -lm


# NUEVO
auxiliar.o: auxiliar.c token.h
	@echo "Compiling" $<" and generating" $@
	@gcc $(CFLAGS) $< -o $@ -lm

$(NAME).o: lex.yy.c token.h
	@echo "Compiling" $<" and generating" $@
	@gcc $(CFLAGS) $< $(LFLAGS) -o $@ -lm

lex.yy.c: $(NAME).l token.h
	@echo "Generating" $@
	@flex $<

.PHONY: clean
clean:
	@echo Deleting auxiliary files
	@rm -f lex.yy.c *.o  

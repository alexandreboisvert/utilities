
# makefile reference: https://makefiletutorial.com

# dependencies
# apt install clang-format
# apt install cppcheck

# Code formatting
# Static compilation to make a more portable executable
# From StackOverflow, solution for opening large files:
# If its 32 bit machine, it will cause some problem for reading a file of
# larger than 4gb. So if you are using gcc compiler try to use the macro
# -D_LARGEFILE_SOURCE=1 and -D_FILE_OFFSET_BITS=64.

template_boilerplate: template_boilerplate.c
	clang-format -i template_boilerplate.c
	cppcheck --check-level=exhaustive template_boilerplate.c
	gcc -static -ansi -pedantic -std=c23 -Wall -Wextra -Werror=all  -lm -D_LARGEFILE_SOURCE=1 -D_FILE_OFFSET_BITS=64 -o template_boilerplate template_boilerplate.c 

# there is no file named "clean"
# the fake file "clean" has no dependencies
# the target "clean" will not create a file named "clean"
# using rm -f to avoid failures if the file does not exist
clean:
	rm -f template_boilerplate



/*
Template/Boilerplate for C code.
*/

/* #include <math.h> */

/* String operations */
#include <string.h>

/* Data-type sizes and extreme values */
#include <limits.h>

/* Standard functions like printf, etc. */
#include <stdio.h>

/* Constants like EXIT_SUCCESS, EXIT_FAILURE, etc. */
#include <stdlib.h>

/* Error numbers, etc.
/usr/include/error.h */
#include <errno.h>

#define PATHS_SIZE 2

/* Print help message */
void print_help();

/* Print limits and extreme values (from limits.h) */
void print_limits();

/* demo errors */
void file_error_demo();

int main(int argc, char **argv) {

  if (argc < 2) {
    printf("Command line arguments required. Try 'help'.\n");
    return EXIT_FAILURE;
  }

  if (strcmp(argv[1], "help") == 0) {
    print_help();
  } else if (strcmp(argv[1], "run_limit") == 0) {
    print_limits();
  } else if (strcmp(argv[1], "run_error") == 0) {
    file_error_demo();
  } else {
    printf("Invalid option, see 'help'\n");
    return EXIT_FAILURE;
  }

  return EXIT_SUCCESS;
}

void print_help() {
  printf("\nTemplate/Boilerplate in C\n\n");
  printf("Command line options:\n");
  printf("  help      : Show this help message and exit\n");
  printf("  run_limit : Show the limits\n");
  printf("  run_error : Display error codes\n\n");
}

void print_limits() {
  printf("Limits\n");

  printf("\nLimits for char:\n");
  printf("Minimum: %d\n", CHAR_MIN);
  printf("Maximum: %d\n", CHAR_MAX);

  printf("\nLimits for unsigned char:\n");
  printf("Maximum: %hd\n", UCHAR_MAX);

  printf("\nLimits for short:\n");
  printf("Minimum: %d\n", SHRT_MIN);
  printf("Maximum: %d\n", SHRT_MAX);

  printf("\nLimits for unsigned short:\n");
  printf("Maximum: %u\n", USHRT_MAX);

  printf("\nLimits for int:\n");
  printf("Minimum: %d\n", INT_MIN);
  printf("Maximum: %d\n", INT_MAX);

  printf("\nLimits for unsigned int:\n");
  printf("Maximum: %u\n", UINT_MAX);

  printf("\nLimits for long:\n");
  printf("Minimum: %ld\n", LONG_MIN);
  printf("Maximum: %ld\n", LONG_MAX);

  printf("\nLimits for unsigned long:\n");
  printf("Maximum: %lu\n", ULONG_MAX);

  printf("\nLimits for long long:\n");
  printf("Minimum: %lld\n", LLONG_MIN);
  printf("Maximum: %lld\n", LLONG_MAX);

  printf("\nLimits for unsigned long long:\n");
  printf("Minimum: %llu\n", ULLONG_MAX);

  printf("\nOther limits:\n");
  printf("Number of bits in a char: %d\n", CHAR_BIT);
}

void file_error_demo() {

  printf("Errors Demo.\n");

  char *paths[PATHS_SIZE];

  paths[0] = "/tmp/invalid_path.txt";
  paths[1] = "/etc/os-release";

  for (int i = 0; i < PATHS_SIZE; i++) {
    printf("\nAttempting to open file '%s'\n", paths[i]);

    FILE *file_handle = fopen(paths[i], "r");

    if (file_handle == NULL) {
      printf("Could not open file '%s'.\n", paths[i]);
      printf("Error number (integer)    : %d\n", errno);
      printf("Error message from the OS : %s\n", strerror(errno));
    } else {
      printf("Open file %s is OK, closing now\n", paths[i]);
      fclose(file_handle);
    }
  }
}

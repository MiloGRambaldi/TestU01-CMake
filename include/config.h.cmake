/* Converted from config.h.in.  */

/* Define to 1 if you have the <dlfcn.h> header file. */
#cmakedefine HAVE_DLFCN_H

/* Define to 1 if you have the `erf' function. */
#cmakedefine HAVE_ERF

/* Define to 1 if you have the <gmp.h> header file. */
#cmakedefine HAVE_GMP_H

/* Define to 1 if you have the <inttypes.h> header file. */
#cmakedefine HAVE_INTTYPES_H

/* Define to 1 if you have the `lgamma' function. */
#cmakedefine HAVE_LGAMMA

/* Define to 1 if you have the `log1p' function. */
#cmakedefine HAVE_LOG1P

/* Define to 1 if the system has the type `long long'. */
#cmakedefine HAVE_LONG_LONG

/* Define when Mathematica is installed */
#cmakedefine Mathematica_FOUND
#ifdef Mathematica_FOUND
#define HAVE_MATHEMATICA 1
#endif

/* Define to 1 if you have the <memory.h> header file. */
#cmakedefine HAVE_MEMORY_H

/* Define to 1 if you have the `random' function. */
#cmakedefine HAVE_RANDOM

/* Define to 1 if you have the <stdint.h> header file. */
#cmakedefine HAVE_STDINT_H

/* Define to 1 if you have the <stdlib.h> header file. */
#cmakedefine HAVE_STDLIB_H

/* Define to 1 if you have the <strings.h> header file. */
#cmakedefine HAVE_STRINGS_H

/* Define to 1 if you have the <string.h> header file. */
#cmakedefine HAVE_STRING_H

/* Define to 1 if you have the <sys/stat.h> header file. */
#cmakedefine HAVE_SYS_STAT_H

/* Define to 1 if you have the <sys/types.h> header file. */
#cmakedefine HAVE_SYS_TYPES_H

/* Define to 1 if you have the <sys/utsname.h> header file. */
#cmakedefine HAVE_SYS_UTSNAME_H

/* Define to 1 if the system has the type `uint32_t'. */
#cmakedefine HAVE_UINT32_T

/* Define to 1 if the system has the type `uint8_t'. */
#cmakedefine HAVE_UINT8_T

/* Define to 1 if you have the <unistd.h> header file. */
#cmakedefine HAVE_UNISTD_H

/* Define to 1 if you have the <windows.h> header file. */
#cmakedefine HAVE_WINDOWS_H

/* Name of package */
#define PACKAGE @PACKAGE@

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT @PACKAGE_BUGREPORT@

/* Define to the full name of this package. */
#define PACKAGE_NAME @PACKAGE_NAME@

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "@PACKAGE_STRING@"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME @PACKAGE_TARNAME@

/* Define to the version of this package. */
#define PACKAGE_VERSION @PACKAGE_VERSION@

/* Define to 1 if you have the ANSI C header files. */
#cmakedefine STDC_HEADERS

/* Version number of package */
#define VERSION @VERSION@

/* Define to 1 if your processor stores words with the most significant byte
   first (like Motorola and SPARC, unlike Intel and VAX). */
#cmakedefine WORDS_BIGENDIAN

/* Define to `unsigned int' if <sys/types.h> does not define. */
#cmakedefine HAVE_SIZE_T
#ifndef HAVE_SIZE_T
#define size_t unsigned int
#endif

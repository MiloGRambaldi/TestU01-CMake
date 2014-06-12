/* Converted from gdefconf.h.in.  */
/* gdef.h  for ANSI C */
#ifndef GDEFCONF_H
#define GDEFCONF_H

#cmakedefine HAVE_LEBOOL

#cmakedefine HAVE_LONG_LONG

#cmakedefine HAVE_ERF

#cmakedefine HAVE_RANDOM

#cmakedefine HAVE_LGAMMA

#cmakedefine HAVE_GMP_H

/* Define when Mathematica is installed */
#cmakedefine Mathematica_FOUND
#ifdef Mathematica_FOUND
#define HAVE_MATHEMATICA 1
#endif

#cmakedefine HAVE_SYS_UTSNAME_H

#cmakedefine HAVE_UNISTD_H

#cmakedefine HAVE_STDINT_H

#cmakedefine HAVE_UINT32_T

#cmakedefine HAVE_UINT8_T

#endif


#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.63])
AC_INIT([smstools3], [3.1.14], [http://smstools3.kekekasvi.com/forum.php?id=4])
AC_CONFIG_SRCDIR([src/smsd.c])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE([-W -Wall])
AC_CANONICAL_HOST

# Checks for programs.
AC_PROG_AWK
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_MAKE_SET

# Checks for header files.
AC_CHECK_HEADERS([fcntl.h limits.h stdlib.h string.h sys/ioctl.h \
                  sys/time.h syslog.h termios.h unistd.h],
                 [], [AC_MSG_ERROR([required C header missing])])

# Checks for typedefs, structures, and compiler characteristics.
AC_TYPE_UID_T
AC_TYPE_MODE_T
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T

# Checks for library functions.
AC_FUNC_FORK
AC_FUNC_GETGROUPS
AC_FUNC_MALLOC
AC_FUNC_MKTIME
AC_FUNC_REALLOC
AC_CHECK_FUNCS([gettimeofday memmove memset regcomp strcasecmp select \
                strchr strdup strerror strncasecmp \
                strrchr strstr strtol], \
               [], [AC_MSG_ERROR([required function missing])])

# Configurable options.
AC_ARG_WITH([no-of-modems],
  [AS_HELP_STRING([--with-no-of-modems=NUM],
    [maximum number of modems, default 64])],
  [no_of_modems=${withval}],
  [no_of_modems=64])

AC_DEFINE_UNQUOTED([NUMBER_OF_MODEMS], [$no_of_modems],
  [Maximum number of modems.])

AC_ARG_WITH([iconv],
  [AS_HELP_STRING([--without-iconv], [do not use iconv])],
  [with_iconv=${withval}],
  [with_iconv=check])

# AS_IF is intentionally not used here as it leads to extra checks under
# AM_ICONV even when the condition is false.
if test "x$with_iconv" != xno
then
  AM_ICONV
  AS_IF([test "x$with_iconv" != xcheck && test "x$am_cv_func_iconv" != xyes],
    [AC_MSG_ERROR([--with-iconv was given, but test for iconv failed])])
fi

AC_ARG_ENABLE([inet-socket],
  [AS_HELP_STRING([--disable-inet-socket], [disable usage of inet socket])],
  [inet_socket=${enableval}],
  [inet_socket=check])

AS_IF([test "x$inet_socket" != xno],
  [AC_CHECK_HEADERS([netdb.h netinet/in.h sys/socket.h])
   AC_SEARCH_LIBS([gethostbyname], [nsl])
   AC_SEARCH_LIBS([socket], [socket])

   test "x$ac_cv_header_netdb_h" = xyes && \
     test "x$ac_cv_header_netinet_in_h" = xyes && \
     test "x$ac_cv_header_sys_socket_h" = xyes && \
     test "x$ac_cv_search_gethostbyname" != xno && \
     test "x$ac_cv_search_socket" != xno && \
     inet_socket_avail=yes
   ])

AS_IF([test "x$inet_socket_avail" != xyes],
  [AS_IF([test "x$inet_socket" = xyes],
    [AC_MSG_ERROR([--enable-inet-socket was given, but requirements missing])],
    [AC_DEFINE([DISABLE_INET_SOCKET], [1],
       [Define to 1 to disable usage of inet socket.])
     AS_IF([test "x$inet_socket" = xcheck],
       [AC_MSG_NOTICE([inet socket disabled due to missing requirements])])
    ])])

AC_ARG_WITH([mm-config],
  [AS_HELP_STRING([--with-mm-config=PATH], [location of libmm mm-config])],
  [mm_config=${withval}],
  [mm_config=""])

AC_ARG_ENABLE([stats],
  [AS_HELP_STRING([--enable-stats], [enable statistics])],
  [enable_stats=${enableval}],
  [enable_stats=no])

AS_IF([test "x$enable_stats" = xyes],
  [AS_IF([test "x$mm_config" != x],
    [AC_MSG_CHECKING(for $mm_config)
     AS_IF([test -f $mm_config],
       [MM_CONFIG=$mm_config
        AC_MSG_RESULT(yes)
       ],
       [AC_MSG_RESULT(no - searching PATH)])])
   AS_IF([test "x$MM_CONFIG" = x],
     [AC_CHECK_PROGS(MM_CONFIG, mm-config)])
   AS_IF([test "x$MM_CONFIG" != x],
     [LIBS="$LIBS `$MM_CONFIG --libs`"
      CFLAGS="$CFLAGS `$MM_CONFIG --cflags`"
      LDFLAGS="$LDFLAGS `$MM_CONFIG --ldflags`"
     ],
     [AC_MSG_ERROR([mm-config not found - please install libmm])])
  ],
  [AC_DEFINE([NOSTATS], [1], [Define to 1 to disable statistics.])])

AC_ARG_ENABLE([force-terminal],
  [AS_HELP_STRING([--enable-force-terminal],
    [force smsd to run in terminal mode])],
  [force_terminal=${enableval}],
  [force_terminal=no])

AS_IF([test "x$force_terminal" = xyes],
  [AC_DEFINE([TERMINAL], [1],
    [Define to 1 to force smsd to run in terminal mode.])])

AC_ARG_ENABLE([debug-messages],
  [AS_HELP_STRING([--enable-debug-messages], [for developers only])],
  [enable_debug_messages=${enableval}],
  [enable_debug_messages=no])

AS_IF([test "x$enable_debug_messages" = xyes],
  [AC_DEFINE([DEBUGMSG], [1],
    [Define to 1 to enable debug messages (for developers only).])])

AC_ARG_ENABLE([debug],
  [AS_HELP_STRING([--enable-debug], [enable debug info])],
  [enable_debug=${enableval}],
  [enable_debug=no])

AS_IF([test "x$enable_debug" = xyes], [CFLAGS="$CFLAGS -ggdb -O0"])

AS_CASE([$host_os],
  [*cygwin*], [AC_DEFINE([CYGWIN], [1], [Define to 1 if building for Cygwin.])]
)

AS_IF([false],
  AC_DEFINE([USE_LINUX_PS_TRICK], [1],
    [Define to 1 on GNU/Linux only if you need ps listing like "smsd: GSM1".]))

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 scripts/Makefile])

AC_OUTPUT

AS_ECHO([--------------------------------------])
AS_ECHO([" Smstools3 build summary:"])
AS_ECHO([])
SMSD_SUMMARY([maximum number of modems  ],
  [:], [$no_of_modems])
SMSD_SUMMARY([use iconv                 ],
  [test "x$am_cv_func_iconv" = xyes],      [yes], [no])
SMSD_SUMMARY([inet socket               ],
  [test "x$inet_socket_avail" = xyes],     [enabled], [disabled])
SMSD_SUMMARY([statistics                ],
  [test "x$enable_stats" = xyes],          [enabled], [disabled])
SMSD_SUMMARY([force terminal mode       ],
  [test "x$force_terminal" = xyes],        [enabled], [disabled])
SMSD_SUMMARY([debug messages            ],
  [test "x$enable_debug_messages" = xyes], [enabled], [disabled])
SMSD_SUMMARY([debug info                ],
  [test "x$enable_debug" = xyes],          [enabled], [disabled])
AS_ECHO([--------------------------------------])

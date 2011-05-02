#! /bin/sh

if test -f Makefile
then
   make distclean
fi

find -name Makefile -exec rm -f {} \;
find -name Makefile.in -exec rm -f {} \;
rm -rf autom4te.cache
rm -f config.h config.h.in configure aclocal.m4 \
      config.guess config.status config.sub config.rpath config.log \
      depcomp install-sh missing

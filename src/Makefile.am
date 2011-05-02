# The following enables logfile size more than 2GB
#CFLAGS += -D _FILE_OFFSET_BITS=64

bin_PROGRAMS = smsd

BUILT_SOURCES = smsd_cfg.h
CLEANFILES = smsd_cfg.h
EXTRA_DIST = smsd_cfg.h.in

smsd_LDADD = @LIBICONV@

smsd_SOURCES = \
  alarm.c \
  alarm.h \
  blacklist.c \
  blacklist.h \
  cfgfile.c \
  cfgfile.h \
  charset.c \
  charset.h \
  extras.c \
  extras.h \
  locking.c \
  locking.h \
  logging.c \
  logging.h \
  modeminit.c \
  modeminit.h \
  pdu.c \
  pdu.h \
  smsd.c \
  smsd_cfg.c \
  stats.c \
  stats.h \
  version.h \
  whitelist.c \
  whitelist.h

nodist_smsd_SOURCES = smsd_cfg.h

do_subst = sed \
            -e 's|@sysconfdir[@]|$(sysconfdir)|g' \
            -e 's|@localstatedir[@]|$(localstatedir)|g'

smsd_cfg.h: smsd_cfg.h.in Makefile
	$(do_subst) $(srcdir)/$@.in >$@

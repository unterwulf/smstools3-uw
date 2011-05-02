SUBDIRS = . src scripts
EXTRA_DIST = doc examples sms3.in smsd.conf.in

sysconf_DATA = smsd.conf
noinst_SCRIPTS = sms3
CLEANFILES = $(noinst_SCRIPTS) smsd.conf

do_subst = sed \
            -e 's|@bindir[@]|$(bindir)|g' \
            -e 's|@localstatedir[@]|$(localstatedir)|g'

sms3: sms3.in Makefile
	$(do_subst) $(srcdir)/$@.in >$@
	chmod 755 $@

smsd.conf: smsd.conf.in Makefile
	$(do_subst) $(srcdir)/$@.in >$@

install-data-local:
	$(install_sh) -d "$(DESTDIR)$(localstatedir)/spool/sms/incoming"
	$(install_sh) -d "$(DESTDIR)$(localstatedir)/spool/sms/outgoing"
	$(install_sh) -d "$(DESTDIR)$(localstatedir)/spool/sms/checked"

uninstall-local:
	rm -rf "$(DESTDIR)$(localstatedir)/spool/sms"

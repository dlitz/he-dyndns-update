DESTDIR ?= tmp/output

all: update-he-dyndns.1

clean:
	rm -f update-he-dyndns.1

mrproper: clean
	rm -rf tmp/output
	-rmdir --ignore-fail-on-non-empty --parents tmp

install: all
	umask 022

	mkdir -p $(DESTDIR)/usr/lib/networkd-dispatcher/routable.d
	cp -t $(DESTDIR)/usr/lib/networkd-dispatcher/routable.d \
		networkd-dispatcher/he-dyndns-update

	mkdir -p $(DESTDIR)/usr/bin
	cp -t $(DESTDIR)/usr/bin \
		update-he-dyndns

	mkdir -p $(DESTDIR)/usr/share/man/man1
	cp -t $(DESTDIR)/usr/share/man/man1 \
		update-he-dyndns.1

	mkdir -p $(DESTDIR)/usr/lib/systemd/system
	cp -t $(DESTDIR)/usr/lib/systemd/system \
		systemd/he-dyndns-update.timer \
		systemd/he-dyndns-update.service

	mkdir -p $(DESTDIR)/etc/he-dyndns-update.d
	cp -T examples/default.yml $(DESTDIR)/etc/he-dyndns-update.d/default.yml
	chmod 750 $(DESTDIR)/etc/he-dyndns-update.d
	chmod 640 $(DESTDIR)/etc/he-dyndns-update.d/default.yml

update-he-dyndns.1: update-he-dyndns
	argparse-manpage \
		--pyfile $< \
		--function make_arg_parser \
		--author "Darsey Litzenberger" \
		--description "Update he.net dynamic DNS" \
		--project-name he-dyndns-update \
		--url https://github.com/dlitz/he-dyndns-update \
		> $@

.PHONY: all install clean

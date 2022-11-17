V=20221117

PREFIX = /usr/local

install:
	install -dm755 $(DESTDIR)$(PREFIX)/share/pacman/keyrings/
	install -m0644 archlinuxarm{.gpg,-trusted,-revoked} $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/share/pacman/keyrings/archlinuxarm{.gpg,-trusted,-revoked}
	rmdir -p --ignore-fail-on-non-empty $(DESTDIR)$(PREFIX)/share/pacman/keyrings/

dist:
	git archive --format=tar --prefix=archlinuxarm-keyring-$(V)/ $(V) | gzip -9 > archlinuxarm-keyring-$(V).tar.gz
	gpg --detach-sign --use-agent archlinuxarm-keyring-$(V).tar.gz

upload:
	scp archlinuxarm-keyring-$(V).tar.gz archlinuxarm-keyring-$(V).tar.gz.sig leming@archlinuxarm.org:www/src

.PHONY: install uninstall dist upload

DESTDIR ?= ~/.local/bin/

.PHONY: install

install:
	install -m 755 fetch_merge_*.sh $(DESTDIR)/.
	install -m 755 fetch_merge.py $(DESTDIR)/.
	echo "Installed to $(DESTDIR)"
	echo "(Note that 'fetch_merge.py' requires the python 'requests' package to be installed.)"
	echo "You also must have $(DESTDIR) in your PATH."

uninstall:
	rm -f $(DESTDIR)/fetch_merge_*.sh
	rm -f $(DESTDIR)/fetch_merge.py
	echo "Uninstalled from $(DESTDIR)"
all:
	$(MAKE) -C adduser all
	$(MAKE) -C deluser all

install:
	$(MAKE) -C adduser DESTDIR=$(DESTDIR) install
	$(MAKE) -C deluser DESTDIR=$(DESTDIR) install

clean:
	$(MAKE) -C adduser clean
	$(MAKE) -C deluser clean

XGETTEXT = xgettext
MSGFMT = msgfmt
MSGMERGE = msgmerge

LOCALEDIR = /usr/share/locale

.SUFFIXES: .po .mo .pot

%.mo: %.po
	$(MSGFMT) -o $@ $<

%.pox: %.po deluser.pot
	$(MSGMERGE) -o $@ $^

LANG = ja fr
MO = $(addsuffix .mo,$(LANG))
POX = $(addsuffix .pox,$(LANG))

all: $(MO)
update: $(POX)

deluser.pot: ../../deluser
	$(XGETTEXT) -k_ -o $@ $<

install: $(MO)
	for i in $(MO) ; do \
	  t=$(DESTDIR)/$(LOCALEDIR)/`basename $$i .mo`/LC_MESSAGES ;\
	  install -d $$t ;\
	  install -m 644 $$i $$t/deluser.mo ;\
	done

clean:
	$(RM) $(MO) *~ deluser.pot

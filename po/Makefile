XGETTEXT = xgettext
MSGFMT = msgfmt
MSGMERGE = msgmerge

LOCALEDIR = /usr/share/locale

.SUFFIXES: .po .mo .pot

%.mo: %.po
	$(MSGFMT) -o $@ $<

%.pox: %.po adduser.pot
	$(MSGMERGE) -o $@ $^

LANG = ca cs da de es fr ja ko nb nl pl pt_BR ru uk zh_CN
MO = $(addsuffix .mo,$(LANG))
POX = $(addsuffix .pox,$(LANG))

all: $(MO)
update: $(POX)

adduser.pot: ../adduser ../deluser ../AdduserCommon.pm
	$(XGETTEXT) -L Perl -k_ -o $@ $?

install: $(MO)
	for i in $(MO) ; do \
	  t=$(DESTDIR)/$(LOCALEDIR)/`basename $$i .mo`/LC_MESSAGES ;\
	  install -d $$t ;\
	  install -m 644 $$i $$t/adduser.mo ;\
	done

clean:
	$(RM) $(MO) *~ adduser.pot *.pox

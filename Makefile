SRC	      = BestMan-Abbrev.inf \
		$(ARCSRC)

ZV            = 8

ARCSRC	      = BestMan-Attack.inf \
		BestMan-Endgame.inf \
		BestMan-Hints.inf \
		BestMan-Mailcar.inf \
		BestMan-Prologue.inf \
		BestMan.inf

PKGSRC	      = bestman.z$(ZV) \
		bmanpkg.pdf \
		bmanmap.pdf \
		walkthru.txt \
		README.txt

PKG	      = bestman.zip

ZCODE	      = bestman.z$(ZV)

DEBUG	      = bestman-d.z$(ZV)

INFOPT	      = -v$(ZV) '$$MAX_LABELS=1200'

all	      : $(DEBUG) $(PKG)

$(ZCODE)      : $(SRC)
	umask 027; inform $(INFOPT) -s -e -~D -~X BestMan.inf $(ZCODE)

$(DEBUG)      : $(SRC)
	umask 077; inform $(INFOPT) -D -X BestMan.inf $(DEBUG)

$(PKG)	      : $(PKGSRC)
	umask 027; zip -o -9 $@ $?

clean	      :
	/bin/rm -f *~

realclean     : clean
	-/bin/rm -f *.z$(ZV) *.zip

BestMan-Abbrev.inf : $(ARCSRC)
	if [ -f $@ ]; then touch $@; else exec $(MAKE) abbrev; fi

abbrev	      :
	@echo "Beginning abbreviation construction..."
	@umask 077; inform -u BestMan.inf tmp.z$(ZV) | \
		grep '^Abbreviate' > BestMan-Abbrev.inf
	@-/bin/rm -f tmp.z$(ZV)

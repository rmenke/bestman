SRC	      = BestMan-Abbrev.inf \
		$(ARCSRC)

ARCSRC	      = BestMan-Attack.inf \
		BestMan-Endgame.inf \
		BestMan-Hints.inf \
		BestMan-Mailcar.inf \
		BestMan-Prologue.inf \
		BestMan.inf

PKGSRC	      = bestman.z5 \
		bmanpkg.pdf \
		bmanmap.pdf \
		walkthru.txt \
		README.txt

PKG	      = bestman.zip

ZCODE	      = bestman.z5

DEBUG	      = bestman-d.z5

BLDTAG	     != date +r%y%m%d

all	      : $(DEBUG) $(PKG)

$(ZCODE)      : $(SRC)
	umask 027; inform $(INFOPT) -s -e -~D -~S -~X BestMan.inf $(ZCODE)

$(DEBUG)      : $(SRC)
	umask 077; inform $(INFOPT) -XD BestMan.inf $(DEBUG)

$(PKG)	      : $(PKGSRC)
	umask 027; zip -o -9 $@ $?

clean	      :
	/bin/rm -f *~

realclean     : clean
	-/bin/rm -f *.z5 *.zip

bestman.z5    : /usr/local/share/inform/6.21/include/newmenus.h
bestman-d.z5  : /usr/local/share/inform/6.21/include/newmenus.h

BestMan-Abbrev.inf : $(ARCSRC)
	if [ -f $@ ]; then touch $@; else exec $(MAKE) abbrev; fi

abbrev	      :
	@echo "Beginning abbreviation construction..."
	@umask 077; inform -u BestMan.inf tmp.z5 | \
		grep '^Abbreviate' > BestMan-Abbrev.inf
	@-/bin/rm -f tmp.z5

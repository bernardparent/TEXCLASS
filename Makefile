SHELL=/bin/sh

clean:
	( cd warpdoc ; make clean )
	( cd waflthesis ; make clean )
	( cd waflreport ; make clean )
	( cd waflarticle ; make clean )
	( cd aiaaarticle ; make clean )
	( cd projector ; make clean )
	( cd tables ; make clean )

cleanall: clean
	( rm -f *~ )
	( rm -f *tgz )
	( cd warpdoc ; make cleanall )
	( cd waflthesis ; make cleanall )
	( cd waflreport ; make cleanall )
	( cd waflarticle ; make cleanall )
	( cd aiaaarticle ; make cleanall )
	( cd projector ; make cleanall )
	( cd tables ; make cleanall )


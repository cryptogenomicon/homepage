WEBHOST = selab
WEBDIR  = /opt/www/people/eddys
TESTDIR = /opt/www/people/eddys/hometest
EMAIL   = eddys@janelia.hhmi.org

FILES = contact.html\
	dnamatrix.css\
	index.html\
	mylinks.html\
	sean.css\
	~/mystuff/cv/cv.pdf\
	sean_email.png

all:    index.html cv.pdf sean_email.png
	for file in ${FILES}; do\
	   scp $$file ${WEBHOST}:${WEBDIR}/;\
	done

index.html:   make_homepage.pl
	./make_homepage.pl F22B7 > index.html

cv.pdf: ~/mystuff/cv/cv.tex
	(cd ~/mystuff/cv; pdflatex cv.tex)
	cp ~/mystuff/cv/cv.pdf .

sean_email.png:
	convert -font Verdana -pointsize 14 label:${EMAIL} sean_email.png

test:   index.html cv.pdf
	ssh ${WEBHOST} mkdir -p ${TESTDIR}
	for file in ${FILES}; do\
	   scp $$file ${WEBHOST}:${TESTDIR}/;\
	done

clean:
	rm index.html
	rm cv.pdf
	rm *~ 

testclean:
	ssh ${WEBHOST} rm -rf ${TESTDIR}

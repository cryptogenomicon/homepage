WEBHOST = seddy@96.126.110.11
WEBDIR  = /var/www/eddylab.org/public_html/people/eddys/
EMAIL   = sean@eddylab.org

FILES = contact.html\
	dnamatrix.css\
	index.html\
	sean.css

all:    index.html 
	for file in ${FILES}; do\
	   scp $$file ${WEBHOST}:${WEBDIR}/;\
	done

index.html:   make_homepage.pl
	./make_homepage.pl F22B7 > index.html

clean:
	rm index.html
	rm *~ 


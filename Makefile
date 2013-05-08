DOMAIN ?= happyleptic.org

all: not-locals.dbm exim4.conf.template

.SUFFIXES: .txt .dbm

.txt.dbm:
	@exim_dbmbuild $< $@

install: exim4.conf.template not-locals.dbm is-in-future
	@if ! test -e /etc/exim4/exim4.conf.template.dist ; then \
	    echo "Saving backup in /etc/exim4/exim4.conf.template.dist" ;\
	    cp -f /etc/exim4/exim4.conf.template /etc/exim4/exim4.conf.template.dist ;\
	fi
	@cp $^ /etc/exim4
	@update-exim4.conf
	@/etc/init.d/exim4 reload

check: checkconf
	@./checkconf

exim4.conf.template: exim4.conf.template.tmpl
	@sed -e 's/\<MAIN_LOCAL_DOMAIN\>/$(DOMAIN)/g' < $< > $@

checkconf: checkconf.tmpl
	@sed -e 's/\<MAIN_LOCAL_DOMAIN\>/$(DOMAIN)/g' < $< > $@
	@chmod a+x $@

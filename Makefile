DOMAIN ?= happyleptic.org

all: not-locals.dbm

.SUFFIXES: .txt .dbm

.txt.dbm:
	@exim_dbmbuild $< $@

install: exim4.conf.template
	@update-exim4.conf
	@/etc/init.d/exim4 reload

check: checkconf
	@./checkconf

exim4.conf.template: exim4.conf.template.tmpl
	@sed -e 's/\<MAIN_LOCAL_DOMAIN\>/$(DOMAIN)/g' < $< > $@

checkconf: checkconf.tmpl
	@sed -e 's/\<MAIN_LOCAL_DOMAIN\>/$(DOMAIN)/g' < $< > $@
	@chmod a+x $@

all: not-locals.dbm

.SUFFIXES: .txt .dbm

.txt.dbm:
	@exim_dbmbuild $< $@

install:
	@update-exim4.conf
	@/etc/init.d/exim4 reload

check:
	@./checkconf

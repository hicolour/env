base: install-base setup-base 

ext: 
	./env-utils/install-ext.sh
	./env-utils/setup-ext.sh

locale-pl:
	./env-utils/setup-locale-pl.sh

design:
	./env-utils/install-ps.sh
	./env-utils/setup-ps.sh

dev: 
	./env-utils/install-dev.sh
	./env-utils/setup-dev.sh


all: base ext dev



setup-base: 
	./env-utils/setup-base.sh
	
install-base: 
	./env-utils/install-base.sh



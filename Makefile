.PHONY: build shell create-dirs restart upgrade upgrade-pihole

build: create-dirs
	docker-compose build \
		--parallel

build-no-cache: create-dirs
	docker-compose build \
		--no-cache \
		--parallel

vpn-shell:
	docker-compose exec pritunl /bin/bash

pritunl-shell: vpn-shell

pihole-shell:
	docker-compose exec pihole /bin/bash

up: create-dirs
	docker-compose up -d

down:
	docker-compose down

proton-status:
	docker-compose exec proton /bin/sh -c 'protonvpn status'

logs:
	docker-compose logs -f

proton-logs:
	docker-compose logs -f proton

pritunl-logs:
	docker-compose logs -f pritunl

pihole-logs:
	docker-compose logs -f pihole

create-dirs:
	mkdir -p pritunl/mongodb pritunl/pritunl
	touch pritunl/pritunl.conf

restart: down up

upgrade-pihole:
	docker pull pihole/pihole

upgrade-pritunl:
	docker pull kyokley/pritunl

upgrade: upgrade-pihole upgrade-pritunl build restart

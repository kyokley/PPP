.PHONY: build shell create-dirs

build: create-dirs
	docker-compose build \
		--parallel \
		--build-arg PROTONVPN_USER=$$PROTONVPN_USER \
		--build-arg PROTONVPN_PASSWORD=$$PROTONVPN_PASSWORD \
		--build-arg PROTONVPN_PLAN=$$PROTONVPN_PLAN \
		--build-arg PROTONVPN_PROTOCOL=$$PROTONVPN_PROTOCOL

build-no-cache: create-dirs
	docker-compose build \
		--no-cache \
		--parallel \
		--build-arg PROTONVPN_USER=$$PROTONVPN_USER \
		--build-arg PROTONVPN_PASSWORD=$$PROTONVPN_PASSWORD \
		--build-arg PROTONVPN_PLAN=$$PROTONVPN_PLAN \
		--build-arg PROTONVPN_PROTOCOL=$$PROTONVPN_PROTOCOL

vpn-shell:
	docker-compose exec pritunl /bin/bash

pihole-shell:
	docker-compose exec pihole /bin/bash

up: create-dirs
	docker-compose up -d
	docker-compose exec pihole /bin/bash -c 'ip route add 192.168.245.0/24 via 172.20.128.2' || true
	docker-compose logs -f

down:
	docker-compose down

logs:
	docker-compose logs -f

create-dirs:
	mkdir -p pritunl/mongodb pritunl/pritunl

restart: down up

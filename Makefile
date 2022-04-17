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
	docker-compose exec softether /bin/bash

up: create-dirs
	docker-compose up -d
	docker-compose logs -f

down:
	docker-compose down

logs:
	docker-compose logs -f

create-dirs:
	mkdir -p softether

vpn-template: create-dirs
	docker-compose run --rm --no-deps --name vpnconf softether echo > softether/vpn_server.config

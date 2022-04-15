.PHONY: build shell

build:
	docker-compose build \
		--parallel \
		--build-arg PROTONVPN_USER=$$PROTONVPN_USER \
		--build-arg PROTONVPN_PASSWORD=$$PROTONVPN_PASSWORD \
		--build-arg PROTONVPN_PLAN=$$PROTONVPN_PLAN \
		--build-arg PROTONVPN_PROTOCOL=$$PROTONVPN_PROTOCOL \

build-no-cache:
	docker-compose build \
		--no-cache \
		--parallel \
		--build-arg PROTONVPN_USER=$$PROTONVPN_USER \
		--build-arg PROTONVPN_PASSWORD=$$PROTONVPN_PASSWORD \
		--build-arg PROTONVPN_PLAN=$$PROTONVPN_PLAN \
		--build-arg PROTONVPN_PROTOCOL=$$PROTONVPN_PROTOCOL \

pritunl-shell:
	docker-compose exec pritunl /bin/bash

up:
	docker-compose up -d
	docker-compose logs -f

down:
	docker-compose down

logs:
	docker-compose logs -f

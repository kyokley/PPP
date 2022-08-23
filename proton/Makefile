build:
	docker build -t kyokley/protonvpn \
		--build-arg PROTONVPN_USER=$$PROTONVPN_USER \
		--build-arg PROTONVPN_PASSWORD=$$PROTONVPN_PASSWORD \
		--build-arg PROTONVPN_PLAN=$$PROTONVPN_PLAN \
		--build-arg PROTONVPN_PROTOCOL=$$PROTONVPN_PROTOCOL \
		--no-cache \
		.

shell: build
	docker run --rm -it --cap-add=NET_ADMIN --device /dev/net/tun kyokley/protonvpn /bin/sh

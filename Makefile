.PHONY: all build update history test

all: build test
	echo Done

build:
    # NPM_CONFIG_PASSWORD will be encoded into the dockerfile history
	docker build --build-arg NPM_CONFIG_USERNAME=npmuser --build-arg NPM_CONFIG_PASSWORD=npmpassword -t docker-image-with-secrets:latest .

update:
	docker pull deepfenceio/deepfence_secret_scanner:latest

history:
	docker history docker-image-with-secrets:latest --no-trunc

test:
	docker run -it --rm --name=deepfence-secretscanner -v $(pwd):/home/deepfence/output -v /var/run/docker.sock:/var/run/docker.sock deepfenceio/deepfence_secret_scanner:latest -debug-level INFO -image-name docker-image-with-secrets:latest | tee result.txt
	# -v /var/run/containerd/containerd.sock:/var/run/containerd/containerd.sock 
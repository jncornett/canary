GOPATH := $(PWD)

ifdef PROFILE
	PROFILE_ARG = "--profile=$(PROFILE)"
endif

env:
	go env
	go version

build:
	go get ./src/dummy/...
	go get ./src/canary/...

package:
	echo $(PROFILE)
	aws cloudformation package --template-file template.yml --s3-bucket ${STAGING_BUCKET} ${PROFILE_ARG}
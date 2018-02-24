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
	aws cloudformation package --output-template-file processed-template.yml --template-file template.yml --s3-bucket ${STAGING_BUCKET} ${PROFILE_ARG}

deploy:
	aws cloudformation deploy --stack-name ${STACK_NAME} --template-file processed-template.yml --capabilities CAPABILITY_IAM ${PROFILE_ARG}
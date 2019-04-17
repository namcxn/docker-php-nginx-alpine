.PHONY: Build and push image

build:
	docker build -t namcx/nginx-php:build .

latest:
	docker build -t namcx/nginx-php:latest .

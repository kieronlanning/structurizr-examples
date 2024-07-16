run:
	@docker run -it --rm -p 8080:8080 -v /workspace:/usr/local/structurizr structurizr/lite

compose:
	@docker-compose -f ./_infra/docker-compose.yml up
	
compose-clean:
	@docker-compose -f ./_infra/docker-compose.yml down
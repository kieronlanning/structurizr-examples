.PHONY: run run-n compose compose-n compose-clean compose-clean-n

run:
	@docker run -it --rm -p 8080:8080 -v ./_infra/.structurizr-data/:/usr/local/structurizr structurizr/lite

run-n:
	@nerdctl run -it --rm -p 8080:8080 -v ./_infra/.structurizr-data/:/usr/local/structurizr structurizr/lite

compose:
	@docker-compose -f ./_infra/docker-compose.yml up
	
compose-n:
	@nerdctl compose -f ./_infra/docker-compose.yml up
	
compose-clean:
	@docker-compose -f ./_infra/docker-compose.yml down

compose-clean-n:
	@nerdctl compose -f ./_infra/docker-compose.yml down
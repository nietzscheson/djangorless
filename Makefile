.PHONY: init

init: down up ps migrate
down:
	docker-compose down --volumes --remove-orphans
pull:
	docker-compose pull
build:
	docker-compose build
up: pull build
	docker-compose up -d
ps:
	docker-compose ps
migrations:
	docker-compose run --rm djangorless python manage.py makemigrations
migrate: migrations
	docker-compose run --rm djangorless python manage.py migrate
# fixtures: migrate
su:
	docker-compose run --rm djangorless python manage.py createsuperuser
test:
	docker-compose run --rm djangorless python manage.py test
shell:
	docker-compose run --rm djangorless python manage.py shell
format:
	docker-compose run --rm djangorless black .
setup:
	docker-compose run --rm djangorless pre-commit install
prune: down
	docker volume prune -f
	docker system prune -f
populatedb:
	docker-compose run --rm djangorless python manage.py populatedb
sls.deploy:
	docker-compose run --rm djangorless sls deploy

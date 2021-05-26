.PHONY: init

init:
	make down
	make up
	make ps
	make migrate
down:
	docker-compose down --volumes --remove-orphans
pull:
	docker-compose pull
build:
	make pull
	docker-compose build
up:
	make build
	docker-compose up -d
ps:
	docker-compose ps
migrations:
	docker-compose exec djangorless python manage.py makemigrations
migrate:
	make migrations
	docker-compose exec djangorless python manage.py migrate
fixtures: 
	make migrate
su:
	docker-compose exec djangorless python manage.py createsuperuser
test:
	docker-compose exec djangorless python manage.py test
shell:
	docker-compose exec djangorless python manage.py shell
prune: 
	make down
	docker volume prune -f
	docker system prune -f
populatedb:
	docker-compose exec djangorless python manage.py populatedb
collecstatic:
	docker-compose exec djangorless python manage.py collectstatic --noinput

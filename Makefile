.PHONY: init

init:
	make down
	make reset_db
	make up
	make ps
	make fixtures
down:
	docker-compose down --volumes --remove-orphans
up:
	docker-compose up --build -d
ps:
	docker-compose ps
migrations:
	docker-compose run --rm core python manage.py makemigrations
migrate:
	make migrations
	docker-compose run --rm core python manage.py migrate
fixtures:
	make migrate
	make populatedb
	# docker-compose run --rm core sh -c "python manage.py makemigrations && python manage.py migrate && python manage.py populatedb"
su:
	docker-compose run --rm core python manage.py createsuperuser
test:
	# docker-compose run --rm core pytest --driver Remote --selenium-host selenium --selenium-port 4444 --capability browserName chrome --cache-clear --disable-warnings -s -n auto
	docker-compose run --rm core pytest
debug:
	docker-compose -f docker-compose.yaml -f docker-compose.debug.yaml up --build -d
remove_files:
	rm -rf core/media/*
prune:
	@make remove_files
	make down
	docker volume prune -f
	docker system prune -f
collecstatic:
	docker-compose run --rm core python manage.py collectstatic --noinput
shell:
	docker-compose exec core python manage.py shell
reset_db:
	docker-compose run --rm core python manage.py reset_db --noinput --close-sessions
populatedb:
	docker-compose run --rm core python manage.py populatedb

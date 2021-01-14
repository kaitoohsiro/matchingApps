up:
		docker-compose up -d
build:
		docker-compose build --no-cache --force-rm
laravel-install:
		docker-compose exec app composer create-project --prefer-dist laravel/laravel laravel-app
create-project:
		@make up
		@make laravel-install
		docker-compose exec app php artisan key:generate
		docker-compose exec app php artisan storage:link
		docker-compose exec app chmod -R 777 storage bootstrap/cache
		@make fresh
init:
		docker-compose up -d
		docker-compose exec app composer install
		docker-compose exec app cp .env.example .env
		docker-compose exec app php artisan key:generate
		docker-compose exec app php artisan storage:link
		docker-compose exec app chmod -R 777 storage bootstrap/cache
		@make fresh
down:
		docker-compose down --remove-orphans
app:
		docker-compose exec app bash
mysql:
		docker-compose exec mysql bash
fresh:
		docker-compose exec app php artisan migrate:fresh --seed
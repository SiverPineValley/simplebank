PG_URL=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable
MS_URL=mysql://root:secret@tcp(localhost:3306)/simple_bank?multiStatements=true

postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14.5-alpine

mysql:
	docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d mysql:8.0.31

createpg:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

createms:
	docker exec -it mysql mysqladmin --user=root --password=secret create simple_bank

dropdb:
	docker exec -it postgres dropdb simple_bank

dropms:
	docker exec -it mysql mysqladmin --user=root --password=secret drop simple_bank

pgup:
	migrate -path db/migration -database "$(PG_URL)" -verbose up

pgdown:
	migrate -path db/migration -database "$(PG_URL)" -verbose down

msup:
	migrate -path db/migration -database "$(MS_URL)" -verbose up

msdown:
	migrate -path db/migration -database "$(MS_URL)" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres mysql createpg createms droppg dropms pgup pgdown msup msdown sqlc test
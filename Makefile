PG_URL=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable
MS_URL=mysql://root:secret@tcp(localhost:3306)/simple_bank?multiStatements=true

postgres:
	docker run --name postgres --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14.5-alpine

mysql:
	docker run --name mysql --network bank-network -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -d mysql:8.0.31

createpg:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

createms:
	docker exec -it mysql mysqladmin --user=root --password=secret create simple_bank

dropdb:
	docker exec -it postgres dropdb simple_bank

dropms:
	docker exec -it mysql mysqladmin --user=root --password=secret drop simple_bank

pgup:
	migrate -path db/migration/postgresql -database "$(PG_URL)" -verbose up

pgup1:
	migrate -path db/migration/postgresql -database "$(PG_URL)" -verbose up 1

pgdown:
	migrate -path db/migration/postgresql -database "$(PG_URL)" -verbose down

pgdown1:
	migrate -path db/migration/postgresql -database "$(PG_URL)" -verbose down 1

msup:
	migrate -path db/migration/mysql -database "$(MS_URL)" -verbose up

msdown:
	migrate -path db/migration/mysql -database "$(MS_URL)" -verbose down

mock:
	mockgen --package mockdb --destination db/mock/store.go simplebank/db/sqlc Store

sqlc:
	sqlc generate

server:
	go run main.go

test:
	go test -v -cover ./...

db_docs:
	dbdocs build doc/db.dbml

db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml

proto:
	rm -rf pb/*.go
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
	--go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	proto/*.proto

.PHONY: postgres mysql createpg createms droppg dropms pgup pgdown pgdown1 msup msdown sqlc test server db_docs db_schema proto
package main

import (
	"database/sql"
	_ "github.com/lib/pq"
	"log"
	"simplebank/api"
	db "simplebank/db/sqlc"
	"simplebank/util"
)

func main() {

	// 0. Load Config
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:",err)
	}

	// 1. Init Database
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}
	store := db.NewStore(conn)

	// 2. Init Server
	server := api.NewServer(store)
	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("cannot start server!!")
	}

	return
}
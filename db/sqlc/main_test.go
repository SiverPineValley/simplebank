package db

import (
	"database/sql"
	"log"
	"os"
	"testing"
	"context"

	_ "github.com/lib/pq"
)

var testQueries *Queries
var testDB *sql.DB

const (
	dbDriver = "postgres"
	dbSource = "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable"
	//dbDriver = "mysql"
	//dbSource = "mysql://root:secret@tcp(localhost:3306)/simple_bank?multiStatements=true"
	)

func TestMain(m *testing.M) {
	var err error

	testDB, err = sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	testQueries = New(testDB)
	exitCode := m.Run()
	os.Exit(exitCode)
}
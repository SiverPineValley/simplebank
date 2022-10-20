package api

import (
	"github.com/gin-gonic/gin"
	db "simplebank/db/sqlc"
)

// Server serves HTTP requests for our banking service.
type Server struct {
	store *db.Store
	router *gin.Engine
}

func NewServer(store *db.Store) 
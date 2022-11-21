package token

import "time"

// Maker is an inteface for managing tokens
type Maker interface {
	// CrateToken creates a new token for a specific username and duration
	CreateToken(username string, duration time.Duration) (string, *Payload, error)

	// VerifyToken checks if the token is valid or not
	VerifyToken(token string) (*Payload, error)
}
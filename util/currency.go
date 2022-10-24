package util

// Constants for all supported currencies
const (
	USD = "USD"
	CAD = "CAD"
	EUR = "EUR"
	KRW = "KRW"
)

// IsSupprotedCurrency returns true if the currency is supported
func IsSupportedCurrency(currency string) bool {
	switch currency {
	case USD, EUR, CAD, KRW:
		return true
	}

	return false
}
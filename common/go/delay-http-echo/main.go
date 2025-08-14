package main

import (
	"encoding/json"
	"log"
	"math/rand"
	"net/http"
	"os"
	"strconv"
	"time"
)

type Response struct {
    Message   string    `json:"message"`
    Time      time.Time `json:"time"`
    Delayed   bool      `json:"delayed"`
    Attempt   int       `json:"attempt"`
    RequestID string    `json:"requestId"`
    Instance  string    `json:"instance"`
}

func handler(w http.ResponseWriter, r *http.Request) {
    delaySeconds := getEnvInt("DELAY_SECONDS", 10)
    delayProbability := getEnvInt("DELAY_PROBABILITY", 20)

    delayed := false
    if rand.Intn(100) < delayProbability {
        time.Sleep(time.Duration(delaySeconds) * time.Second)
        delayed = true
    }

    attempt := 0
    if v := r.Header.Get("X-Envoy-Attempt-Count"); v != "" {
        if n, err := strconv.Atoi(v); err == nil {
            attempt = n
        }
    }
    reqID := r.Header.Get("X-Request-Id")
    host, _ := os.Hostname()

    w.Header().Set("Content-Type", "application/json")
    w.Header().Set("X-App-Attempt-Seen", strconv.Itoa(attempt))
    w.Header().Set("X-App-Delayed", strconv.FormatBool(delayed))

    _ = json.NewEncoder(w).Encode(Response{
        Message:   "hello",
        Time:      time.Now(),
        Delayed:   delayed,
        Attempt:   attempt,
        RequestID: reqID,
        Instance:  host,
    })
}

func main() {
	rand.Seed(time.Now().UnixNano())

	http.HandleFunc("/", handler)

	port := ":8080"
	log.Printf("Server listening on %s", port)
	if err := http.ListenAndServe(port, nil); err != nil {
		log.Fatal(err)
	}
}

func getEnvInt(key string, defaultVal int) int {
	if val, ok := os.LookupEnv(key); ok {
		if i, err := strconv.Atoi(val); err == nil {
			return i
		}
	}
	return defaultVal
}

package main

import (
	"fmt"
	"log"
	"net/url"

	"github.com/golang-migrate/migrate/v4"
	_ "github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	"github.com/namsral/flag"
)

func main() {
	var dbURL = "{database url}"
	flag.StringVar(&dbURL, "url", dbURL, "the url database of the flag")
	var username = "{database username}"
	flag.StringVar(&username, "username", username, "the username database of the flag")
	var password = "{database password}"
	flag.StringVar(&password, "password", password, "the password database of the flag")
	var name = "{database name}"
	flag.StringVar(&name, "name", name, "the name database of the flag")
	var port = 5432
	flag.IntVar(&port, "port", port, "the port database of the flag")
	var steps = 0
	flag.IntVar(&steps, "steps", steps, "the steps database of the flag")
	flag.Parse()

	dbConURL := fmt.Sprintf("postgres://%s:%s@%s:%d/%s?sslmode=disable",
		url.QueryEscape(username),
		url.QueryEscape(password),
		dbURL,
		port,
		name)
	m, err := migrate.New("file://migrations", dbConURL)
	if err != nil {
		log.Fatal(err)
	}
	log.Println("Start Migrate")
	if steps > 0 {
		if err := m.Steps(steps); err != nil && err != migrate.ErrNoChange {
			log.Fatal(err)
		}
	} else {
		if err := m.Up(); err != nil && err != migrate.ErrNoChange {
			log.Fatal(err)
		}
	}
	log.Println("Success")
}

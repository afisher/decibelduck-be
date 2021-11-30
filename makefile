SHELL := /bin/bash


.PHONY: run tidy

-include .env
export


# error if an environment variable was unset when this is checked
checkenv-%:
	$(if ${${*}},,$(error ${*} is undefined))


run: checkenv-PGHOST checkenv-PGUSER checkenv-PGPASSWORD checkenv-PGDATABASE
	uvicorn --reload decibelduck.main:app

tidy:
	isort src/
	black src/

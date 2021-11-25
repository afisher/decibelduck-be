SHELL := /usr/bin/bash


run:
	uvicorn --reload decibelduck.main:app

tidy:
	isort src/
	black src/

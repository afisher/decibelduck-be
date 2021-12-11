"""
Load configuration from the environment

CONFIG is a global settings variable
"""
from pydantic import BaseSettings, Field


class Config(BaseSettings):
    """
    Settings are loaded from the environment into the attributes that have a matching name
    """

    pgdatabase: str = Field(default="decibelduck")


CONFIG = Config()

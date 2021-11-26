"""
Load configuration from the environment

CONFIG is a global settings variable
"""
from urllib.parse import urlparse

from pydantic import BaseSettings


class Config(BaseSettings):
    """
    Settings are loaded from the environment into the attributes that have a matching name
    """
    pgdatabase: str


CONFIG = Config()

"""
Load configuration from the environment

CONFIG is a global settings variable
"""
import typing

from pydantic import BaseSettings, Field, BaseModel


class CORSSettings(BaseModel):
    """
    Settings container for the 4 basic things you can set with CORS 
    """
    allow_origins: typing.List[str] = ("*",)
    allow_credentials: bool = True
    allow_methods: typing.List[str] = ("*",)
    allow_headers: typing.List[str] = ("*",)


class Config(BaseSettings):
    """
    Settings are loaded from the environment into the attributes that have a matching name
    """

    pgdatabase: str = Field(default="decibelduck")

    # NOTE: BaseSettings can parse environment variables with a json data structure.
    # Example: 
    # $ export DD_CORS_SETTINGS='{"allow_origins": ["*"], "allow_credentials": true, "allow_methods": ["*"], "allow_headers": ["*"]}'
    # 
    dd_cors_settings: CORSSettings = CORSSettings()


CONFIG = Config()

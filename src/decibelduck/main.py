"""
API root - start the ASGI server
"""
import logging

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from decibelduck import database
from decibelduck.config import CONFIG
from decibelduck.log import logger
from decibelduck.soundfile import SoundFile, SoundFileList

app = FastAPI()
app.add_middleware(CORSMiddleware, **CONFIG.dd_cors_settings.dict())


@app.get("/")
async def root() -> dict:
    """
    No-op, this will never be something interesting
    """
    return {"message": "nothing to see here"}


@app.get("/sounds")
async def sounds() -> SoundFileList:
    """
    List of SoundFile objects matching a query
    """
    return SoundFileList(
        items=[
            SoundFile(
                url="https://storage.googleapis.com/sounds-decibelduck-com/ogg/345689__inspectorj__comedic-boing-a.ogg"
            )
        ]
    )


@app.on_event("startup")
async def logging_on():
    """
    Turn on logging
    """
    uvicornLogger = logging.getLogger("uvicorn")
    uvicornLogger.propagate = False
    uvicornLogger.info("🚲 🦆 🎵")

    logger.info("starting")


@app.on_event("startup")
async def attach_database():
    """
    Connect to the database at FastAPI startup
    """
    await database.do_database_thing()

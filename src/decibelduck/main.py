"""
API root - start the ASGI server
"""
import logging

from fastapi import FastAPI

from decibelduck import database
from decibelduck.log import logger
from decibelduck.soundfile import SoundFileList, SoundFile


app = FastAPI()


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
async def startup_server():
    """
    Connect to the database at FastAPI startup
    """
    uvicornLogger = logging.getLogger("uvicorn")
    uvicornLogger.propagate = False
    uvicornLogger.info("🚲 🦆 🎵")

    logger.info("starting")

    await database.do_database_thing()

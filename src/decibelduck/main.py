"""
API root
"""
from fastapi import FastAPI

from decibelduck.soundfile import SoundFileList, SoundFile


app = FastAPI()


@app.get("/")
async def root() -> dict:
    return {"message": "nothing to see here"}


@app.get("/sounds")
async def sounds() -> SoundFileList:
    return SoundFileList(
        items=[
            SoundFile(
                url="https://storage.googleapis.com/sounds-decibelduck-com/ogg/345689__inspectorj__comedic-boing-a.ogg"
            )
        ]
    )

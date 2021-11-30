import typing

from pydantic import BaseModel


class SoundFile(BaseModel):
    url: str


class SoundFileList(BaseModel):
    items: typing.List[SoundFile]
    query: str = ""

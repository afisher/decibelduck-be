"""
Sound file models and bucket ops
"""
import typing

from pydantic import BaseModel

from decibelduck import cloudstorage


HARDCODED_BUCKET = "sounds-decibelduck-com"
HARDCODED_PREFIX = "ogg/"


class SoundFile(BaseModel):
    url: str


class SoundFileList(BaseModel):
    items: typing.List[SoundFile]
    query: str = ""

    @classmethod
    def from_bucket_prefix(cls, bucket=HARDCODED_BUCKET, prefix=HARDCODED_PREFIX) -> "SoundFileList":
        """
        List soundfiles by listing a cloud storage bucket/prefix
        """
        return cls(
            items=[SoundFile(url=u) for u in cloudstorage.list_bucket(bucket, prefix)]
        )

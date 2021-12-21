"""
Layer to interface with Google Cloud Storage

Blocking; if used in FastAPI make sure methods are NOT async (this tells fastapi to thread them)
"""
import typing

from google.cloud.storage import Client


LINK_TPL = "https://storage.cloud.google.com/{bucket.name}/{obj.name}"


def list_bucket(bucket, prefix) -> typing.List[str]:
    """
    A sorted list of URLs to the items in the bucket
    """
    cli = Client()
    bucket = cli.get_bucket(bucket)
    blobbies = cli.list_blobs(bucket, prefix=prefix)
    return [LINK_TPL.format(bucket=bucket, obj=obj) for obj in blobbies]

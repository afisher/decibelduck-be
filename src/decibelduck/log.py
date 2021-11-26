"""
Logging in one place
"""
import logging
import sys

from pythonjsonlogger import jsonlogger


logger = None


def _setup_logging() -> logging.Logger:
    global logger
    logger = logging.getLogger("decibelduck")
    logger.setLevel(logging.DEBUG)
    json_handler = logging.StreamHandler(sys.stdout)
    formatter = jsonlogger.JsonFormatter(
        fmt='%(asctime)s %(levelname)s %(name)s %(message)s'
    )
    json_handler.setFormatter(formatter)
    logger.addHandler(json_handler)

    return logger

_setup_logging()

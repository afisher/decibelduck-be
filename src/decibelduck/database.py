"""
Database interface using peewee-async
"""
import peewee
import peewee_async

from decibelduck.config import CONFIG
from decibelduck.log import logger


# start with an unconnected database and init later
_database = peewee_async.PostgresqlDatabase(CONFIG.pgdatabase)
class TestModel(peewee.Model):
    """
    Throwaway model, for poc only
    """
    text = peewee.CharField()

    class Meta:
        database = _database


async def do_database_thing():
    """
    Throaway database init, for poc only
    """
    _database.init(CONFIG.pgdatabase)
    TestModel.create_table()
    _database.set_allow_sync(False)

    objects = peewee_async.Manager(_database)

    async def handler():
        await objects.create(TestModel, text="Not bad. Watch this, I'm async!")
        all_objects = await objects.execute(TestModel.select())
        for obj in all_objects:
            logger.info(obj.text)
        with _database.allow_sync():
            TestModel.drop_table(True)

    await handler()

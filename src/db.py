import os
from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()


def get_database_url() -> str:
    """Build database URL from environment variables."""
    user = os.getenv("PGUSER")
    password = os.getenv("PGPASSWORD")
    host = os.getenv("PGHOST")
    port = os.getenv("PGPORT")
    database = os.getenv("PGDATABASE")

    return f"postgresql://{user}:{password}@{host}:{port}/{database}"


def get_engine(echo: bool = False):
    """Return a reusable SQLAlchemy engine."""
    return create_engine(get_database_url(), echo=echo, future=True)
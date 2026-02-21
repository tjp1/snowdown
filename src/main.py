from sqlalchemy import text
from db import get_engine

def main():
    engine = get_engine()

    with engine.connect() as conn:
        result = conn.execute(text("select count(1) from lift_usage;"))
        count = result.scalar()
        print(f"Lift usage count: {count}")

if __name__ == "__main__":
    main
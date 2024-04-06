from fastapi import FastAPI
import uvicorn

from db.base import Base, engine
from entities.user import User

app = FastAPI()


def create_tables():
    Base.metadata.create_all(bind=engine)


@app.on_event("startup")
def on_startup():
    create_tables()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}

# if __name__ == '__main__':
#     uvicorn.run("app:app",
#                 host="localhost",
#                 port=8000,
#                 reload=True)

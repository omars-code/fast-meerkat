from beanie import Document
from uuid import UUID, uuid4
from pydantic import Field


class PostDocument(Document):
    id: UUID = Field(default_factory=uuid4)
    title: str
    body: str
    published: bool = False


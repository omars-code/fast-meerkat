from injector import inject

from meerkat.data_providers.database.mongo.documents import PostDocument
from meerkat.data_providers.database.mongo.transformers import PostDocumentTransformer
from meerkat.domain.common.value_objects import Id
from meerkat.domain.post.data_providers import PostDataProvider
from meerkat.domain.post.data_providers.exceptions import EntityNotFoundException
from meerkat.domain.post.entities import Post


class PostMongoRepository(PostDataProvider):
    @inject
    def __init__(self, transformer: PostDocumentTransformer):
        self.transformer = transformer

    async def save(self, post: Post):
        post_document = self.transformer.transform_to_document(post)
        await post_document.save()

    async def get(self, doc_id: Id) -> Post:
        posts = await PostDocument.find(PostDocument.id == doc_id.value).to_list()
        if len(posts) < 1:
            raise EntityNotFoundException(
                "Cannot find document with id #{}".format(str(doc_id))
            )

        return self.transformer.transform_to_domain_object(posts[0])

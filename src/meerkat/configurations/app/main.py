from injectorfount import InjectorFount
from serviceregistry.services import Container, Registry

from meerkat.configurations.app import settings
from fastapi import FastAPI

app = FastAPI()

def create_container():
    container = Container()

    container.set(settings.Props.DI_PROVIDER, InjectorFount())
    container.set(settings.Props.FALCON, app)
    return container


container = create_container()


def boot():
    service_registry = Registry()

    for service in settings.services:
        service_registry.register(service)

    service_registry.boot(container)


boot()

# fast meerkat

What do I get out of the box ?

-   Clean Architecture in Python

-   FastAPI RESTful API example

-   Health endpoint example

-   Docker example


But what does it mean ?

-   Means it can be a starter project for your next project, whether FastAPI, Falcon, Fask or CLI or * seriously any.

Now let's get started.

Installing the precommit/prepush hooks
## API docs

http://0.0.0.0:8021/docs

## new service [how-to]
Write
- AggregateRoot
- data provider definitions [domain]
- data provider concrete implementation
- usecase
- Rest
  - definitions 
  - schemas
- configurations/di
- configurations/rest/resouce

## Running the app

```shell
make start
```

## Local Development Setup

```sh
# Install dependencies
pipenv install --dev --deploy

# Setup pre-commit and pre-push hooks
pipenv run pre-commit install -t pre-commit
pipenv run pre-commit install -t pre-push
```

running tests:
```shell
make test
```
coverage found at: htmlcov/index.html
## Credits
- [sourcery-ai/python-best-practices-cookiecutter](https://github.com/sourcery-ai/python-best-practices-cookiecutter) project template. 

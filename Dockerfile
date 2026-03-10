FROM python:3.13-slim

# install pipx
RUN apt-get update && apt-get install -y pipx
RUN pipx ensurepath

# install poetry
RUN pip3 install poetry

# working dir
WORKDIR /app

# install poetry dependencies
COPY pyproject.toml ./
RUN pipx run poetry install --no-root

# copy app to container
COPY todo todo

# running the app
CMD ["bash", "-c", "sleep 10 && pipx run poetry run flask --app todo run \
--host 0.0.0.0 --port 6400"]
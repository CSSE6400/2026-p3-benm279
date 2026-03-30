FROM python:3.13-slim

# Install pipx 
RUN apt-get update && apt-get install -y pipx 
RUN pipx ensurepath 
 
# Install poetry 
RUN pip3 install poetry

# set workdir
WORKDIR /app

# install dependencies
COPY pyproject.toml ./
RUN pipx run poetry install --no-root

# copy app to container
COPY todo todo

# run the app
# Adding a delay to our application startup 
CMD ["bash", "-c", "pipx run poetry run flask --app todo run --host 0.0.0.0 --port 6400"]
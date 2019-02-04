# Dockerfile
FROM python:3

WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y python-pdal

RUN git clone https://github.com/audaciouscode/PassiveDataKit-Django.git /app/passive_data_kit
WORKDIR /app/passive_data_kit
RUN git checkout 55bb567cbbb5068a5ca14dcf91a537db537f284f

RUN sed -i -e 's/futures/#futures/g' requirements.txt # There is a problem with this Python package. Solve later.
RUN pip install -r requirements.txt

WORKDIR /app

EXPOSE 8000

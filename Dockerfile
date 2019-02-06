# Dockerfile
FROM python:2.7

RUN apt-get update
RUN apt-get install -y python-pdal apache2 apache2-utils libapache2-mod-wsgi

COPY . /var/www/html/app
ADD ./demo_site.conf /etc/apache2/sites-available/000-default.conf

RUN git clone https://github.com/audaciouscode/PassiveDataKit-Django.git /var/www/html/app/passive_data_kit
WORKDIR /var/www/html/app/passive_data_kit
RUN git checkout 55bb567cbbb5068a5ca14dcf91a537db537f284f

RUN sed -i -e 's/futures/#futures/g' requirements.txt # There is a problem with this Python package. Solve later.
RUN pip install -r requirements.txt

EXPOSE 80 3500 8000
CMD ["apache2ctl", "-D", "FOREGROUND"]

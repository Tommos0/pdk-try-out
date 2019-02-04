# pdk-try-out
repository for notes and scripts related to trying out the Passive Data Kit

1.	Clone repo, zorg dat je Docker & docker-compose hebt geinstalleerd & zorg dat er niks draait op poort `5432` (dit is posgres default).
2.	Ga naar folder
3.	sudo docker-compose up -d postgres
4.	sudo docker-compose run django python manage.py migrate
5.	sudo docker-compose run django python manage.py createsuperuser
6.	sudo docker-compose up


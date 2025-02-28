FROM python:3.6-alpine

ENV FLASK_APP flasky.py
ENV FLASK_CONFIG default

RUN adduser -D flasky
USER flasky

WORKDIR /home/flasky

COPY requirements requirements
RUN python -m venv venv
RUN venv/bin/pip install -r requirements/dev.txt
RUN venv/bin/pip install gunicorn

COPY app app
COPY migrations migrations
COPY flasky.py config.py boot.sh ./

# run-time configuration
EXPOSE 5000
#ENTRYPOINT ["./boot.sh"]
ENTRYPOINT ["./venv/bin/flask run"]


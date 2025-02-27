FROM python:3.10 as py

FROM py as build

RUN apt update && apt install -y g++ git
COPY requirements.txt /
RUN pip install --prefix=/inst -U -r /requirements.txt

FROM py

ENV USING_DOCKER yes
COPY --from=build /inst /usr/local

WORKDIR /modmailbot
CMD ["python", "bot.py"]
COPY . /modmailbot
RUN adduser --disabled-password --gecos '' app && \
  chown -R app /modmailbot
USER app

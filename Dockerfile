# vim:set ft=dockerfile:
FROM debian:jessie
MAINTAINER Gregor Jerše <gregor@jerse.info>

ENV TOMO_GIT_LOCATION=https://github.com/matijapretnar/projekt-tomo.git
ENV TOMO_GIT_BRANCH=master

# Secret key is only here to make collectstatic work.
# It is overrided from settings in docker-compose.
ENV SECRET_KEY=very_secret_key

# Add Tomo user and group first to make sure their IDs get assigned consistently
RUN groupadd -r tomo && useradd -r -g tomo tomo

# Install required packages
RUN apt-get update \
  && apt-get install -y \
  uwsgi \
  uwsgi-plugin-python \
  python2.7 \
  python-pip \
  git \
  postgresql-server-dev-9.4 \
  python-ldap \
  libpython2.7-dev \
  libldap2-dev \
  libsasl2-dev \
   && rm -rf /var/lib/apt/lists/*

WORKDIR /home/tomo

# Pull tomo source into current working directory
RUN git clone -b ${TOMO_GIT_BRANCH} ${TOMO_GIT_LOCATION}

# Install dependencies
RUN pip install -r projekt-tomo/web/requirements/arnes.txt

ENV SOCIAL_AUTH_GOOGLE_OAUTH2_KEY=very_secret_key
ENV SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET=very_secret_key
ENV SOCIAL_AUTH_FACEBOOK_KEY=very_secret_key
ENV SOCIAL_AUTH_FACEBOOK_SECRET=very_secret_key
ENV SOCIAL_AUTH_TWITTER_KEY=very_secret_key
ENV SOCIAL_AUTH_TWITTER_SECRET=very_secret_key

RUN python projekt-tomo/web/manage.py collectstatic --noinput --settings=web.settings.arnes
RUN chown tomo.tomo -R /home/tomo

# UWSGI options are read from environmental variables.
# They are specified in docker-compose file.
CMD ["uwsgi"]


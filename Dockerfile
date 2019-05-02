FROM ruby:2.6.3

ENV RAILS_ENV=production

EXPOSE 3000

ENTRYPOINT ["/usr/bin/app/entrypoint.sh"]

# https://github.com/nodesource/distributions#installation-instructions
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -


RUN apt-get update && apt-get install -y nodejs ffmpeg imagemagick pdftk ghostscript graphviz sqlite3 cron anacron --no-install-recommends && rm -rf /var/lib/apt/lists/*

COPY ./.delete_upload_caches.sh /etc/cron.weekly/delete_upload_caches.sh
RUN chmod 555 /etc/cron.weekly/delete_upload_caches.sh
COPY ./.destroy_expired_quizzes.sh /etc/cron.daily/destroy_expired_quizzes.sh
RUN chmod 555 /etc/cron.daily/destroy_expired_quizzes.sh

RUN useradd -g 501 -u 501 -m -d /usr/src/app app
WORKDIR /usr/src/app
USER app

COPY ./Gemfile /usr/src/app
COPY ./Gemfile.lock /usr/src/app
RUN bundle install
COPY ./ /usr/src/app

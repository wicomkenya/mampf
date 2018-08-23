[![Coverage Status](https://coveralls.io/repos/github/fosterfarrell9/mampf/badge.svg?branch=master)](https://coveralls.io/github/fosterfarrell9/mampf?branch=master)
[![Build Status](https://travis-ci.org/fosterfarrell9/mampf.svg?branch=master)](https://travis-ci.org/fosterfarrell9/mampf)
[![Maintainability](https://api.codeclimate.com/v1/badges/5759a52c062a4a4b2faf/maintainability)](https://codeclimate.com/github/fosterfarrell9/mampf/maintainability)

# README

* Ruby version: 2.5.1
* Rails Version: 5.2.1
* Test suite: rspec

## Installation (with Docker)

 1. Install Database Server (e.g. PostgreSQL) and create Database.  
   (Don't forget to allow access for the docker network)
```
createuser mampf
createdb -O mampf mampf
psql -c "ALTER USER mampf PASSWORD '$PASSWORD'" 
```
 2. Create an environment file like this:
```
RAILS_ENV=production
PRODUCTION_DATABASE_ADAPTER=postgresql
PRODUCTION_DATABASE_DATABASE=mampf
PRODUCTION_DATABASE_USERNAME=mampf
PRODUCTION_DATABASE_PASSWORD=$DATABASE_PASSWORD
PRODUCTION_DATABASE_HOST=172.17.0.1
PRODUCTION_DATABASE_PORT=5432
MAILSERVER=localhost
FROM_ADDRESS=mampf@localhost
URL_HOST=localhost
RAILS_MASTER_KEY=$MASTER_KEY
```
 3. Execute the following commands to install and run the service: 
```
git clone -b master git@github.com:fosterfarrell9/mampf.git
docker build --label "mampf" mampf
docker create --name mampf --env-file $ENVFILE -p $OUTSIDEPORT:3000 $IMAGEID
docker run --rm --env-file $ENVFILE $IMAGEID 'rm config/credentials.yml.enc && bundle exec rails credentials:edit'
docker start mampf
docker exec mampf bundle exec rake db:migrate
docker exec mampf bundle exec rake db:seed
docker exec mampf bundle exec rake assets:precompile
docker stop mampf
docker start mampf
```
Now you can access *mampf* via `http://localhost:$OUTSIDEPORT`.

**Note**  
Currently the `docker run` line is not working and the encrypted credentials file has to be replaced by hand.

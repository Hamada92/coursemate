# Coursemate [![CircleCI](https://circleci.com/gh/coursemate/coursemate.svg?style=svg&circle-token=c34eda82b1bb2dd3fc061646d9e96b8fab74dbf9)](https://circleci.com/gh/coursemate/coursemate)

## Local setup (macOS)

### Ruby/Rails
https://gorails.com/setup/osx

### Postgres
```
brew install postgresql
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start 
```
### Redis
```
brew install redis
redis-server /usr/local/etc/redis.conf
bundle exec sidekiq -q default -q mailers
```

### ImageMagick
```
brew install imagemagick
```
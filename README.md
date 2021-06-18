# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## Install

```sh
bundle install
```
## Ruby version
  '2.5.7'
## System dependencies
* ruby 2.5.1
* postgresql

## Run
- `rails s` to start the rails server

## Database creation

  *Creating role with postgres
```sh
  sudo su  postgres
  psql
>  create ROLE postgres;
  #alter role with login
>  ALTER ROLE "postgres" WITH LOGIN;
  #alter rolle with creartdb
>  ALTER USER postgres CREATEDB;
```
// Create the database
```sh
  rake db:create
```
// Run the migration files
```sh
  rake db:migrate
```
##Using rubocop
  *Finding indentation error run
```sh
  rubucop
```
  *For auto-correct run
```sh
  rubocop -A
```
  *Or
```sh
  rubocop --auto-correct-all
```
  *To stop test the specific type in Rubocop linter, you can add the test type name in './.rubocop.yml'
```sh
  ex: Style/Encoding:
        Enabled: false
```

*For running or not running a specific file add file name in AllCops, Exclude/Include in '.rubocop.yml'

T## How to run the test suite
  #RSPEC Test:

  *For running all test:
```sh
  rspec
```
*For running specific test:
```sh
  rspec spec/your_test_path
```

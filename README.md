# Sinatra Portfolio Project- Accounted For

## Overview

This program is a quick way to take notes, set tasks, and catalog relevant information for multiple businesses.

## About This Project

This project uses the [Sinatra](http://sinatrarb.com/) library, a framework written in Ruby and used to quickly build web applications.

## Installation instructions

Clone this repo into your local environment and run the following commands:

1. `$ gem install bundler` ... to install [Bundler](https://bundler.io/)
1. `$ bundle install` ... to install the [Ruby Gems](https://rubygems.org/).
2. `$ shotgun` ... to boot up your server

copy the domain in you command prompt and paste it into a web browser.

## Project File Structure
```
├── spec.md
├── config.ru
├── Gemfile
├── Gemfile.lock
├── LICENSE.md
├── README.md
├── Rakefile
├── story_dev
├── app
│   ├── controllers
│   │   ├── application_controller.rb
│   │   ├── client_company_controller.rb
│   │   ├── client_controller.rb
│   │   ├── note_controller.rb
│   │   ├── tasks_controller.rb
│   │   ├── user_company_controller.rb
│   │   └── users_controller.rb
│   ├── models
│   │   ├── client_company.rb
│   │   ├── client_job_title.rb
│   │   ├── client.rb
│   │   ├── industr.rb
│   │   ├── job.rb
│   │   ├── note.rb
│   │   ├── notification.rb
│   │   ├── task.rb
│   │   ├── user_company.rb
│   │   ├── user_job_title.rb
│   │   └── user.rb
│   └── views
│       ├──client_companies
│       │   ├── edit.erb
│       │   ├── index.erb
│       │   ├── new.rb
│       │   └── show.rb
│       ├── clients
│       │   ├── edit.erb
|       |   |    ├──add_client_companies.erb
|       |   |    └──edit_client.erb
│       │   ├── new.rb
|       |   |     ├──add_companies.erb
|       |   |     └──new_client.erb
|       |   └──index.erb
│       ├── layouts
│       │   └── login_layout.erb
│       ├──notes
│       │   ├── edit.erb
│       │   ├── index.erb
│       │   └── new.rb
│       ├──tasks
│       │   ├── edit.erb
│       │   ├── index.erb
│       │   └── new.rb
│       ├──user
│       │   ├── edit.erb
│       │   ├── index.erb
│       │   └── new.rb
│       ├──user_company
│       │   ├── edit.erb
│       │   ├── index.erb
|       |   ├── new.erb
|       |   ├── show.erb
│       │   └── signup.rb
│       ├── index.erb
│       ├── layout.erb
│       └── signup.erb
├── config
│   └── environment.rb
├── config.ru
└── db
    ├── development.sqlite
    ├── migrate
    ├── schema.rb
    └── seeds.rb
```

## License Link
<a href='https://opensource.org/licenses/MIT'>License link</a>

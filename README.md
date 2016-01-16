[![Code Climate](https://codeclimate.com/github/kevinlanzon/yelp-clone/badges/gpa.svg)](https://codeclimate.com/github/kevinlanzon/yelp-clone)
[![Build Status](https://travis-ci.org/kevinlanzon/yelp4curry.svg?branch=master)](https://travis-ci.org/kevinlanzon/yelp4curry)
[![Test Coverage](https://codeclimate.com/github/kevinlanzon/yelp-clone/badges/coverage.svg)](https://codeclimate.com/github/kevinlanzon/yelp-clone/coverage)
FindACurry
==========

This project is a clone of [Yelp](http://www.yelp.co.uk/). The goal is to introduce you to Rails (and find the best curry in your area), focusing especially on:

- Creating Rails applications
- The structure of Rails apps (MVC, the router, helpers)
- TDD in Rails, with RSpec & Capybara
- Associations
- Validations
- AJAX in Rails

The objectives of this exercise was OOD, learning folder structure, setting up a postgresql database and TDD...and find an awesome curry.

Screenshot
---
<div align="center">
        <img width="100%" src="/app/assets/images/curry_4_yelp.jpg">

</div>

View live
-----
[FindACurry](https://find-a-curry.herokuapp.com/)

Technologies used
----
- Ruby
- Ruby on Rails
- RSpec
- Capybara
- PostgreSQL
- FactoryGirl
- Devise
- Shoulda
- Paperclip
- ImageMagick
- Poltergeist
- AJAX
- CoffeeScript
- Haml
- AWS S3
- Bootstrap
- Masonry
- CSS

How to clone this repo
----
```sh
git clone git@github.com:kevinlanzon/yelp-clone.git
```

How to run
----
```sh
run bundle install
rake db:migrate
rails s
```

How to run tests
----
```sh
run rspec
```

# Vacations

Application for planning vacations.

## Installation and runing

###To run the application, you need to:

1. Установить ruby '2.5.0' version;
2. Установить Ruby on rails '5.1.4' version;
3. Go to the project local and run <bundle> in terminal or iterm, для установки гемов.
4. Run <rails db:migrate> для добавления миграций в базу данных.
5. Run <rails db:seed> для установки тестовых пользователей в базу данных.
	В базу данных будут добавлены три пользователя:
	1. email: "one@test.com", password: "111222", employment_date: "2016-01-01"
	2. email: "two@test.com", password: "111222", employment_date: "2017-01-01"
	3. email: "three@test.com", password: "111222", employment_date: "2018-01-01"
6. Run <rails s> to start server, go to url: 'localhost:3000'.
 
## Dependencies

###Version of gems:
gem 'rails', '5.1.4'
gem 'sqlite3', '1.3.13'
gem 'puma', '3.11.0'
gem 'less-rails', '2.8.0'
gem 'sass-rails', '5.0.7'
gem 'uglifier', '4.1.2'
gem 'therubyracer', '0.12.3'
gem 'turbolinks', '5.0.1'
gem 'jbuilder', '2.7.0'
gem 'bcrypt', '3.1.11'
gem 'byebug', '9.1.0'
gem 'capybara', '2.17.0'
gem 'selenium-webdriver', '3.8.0'
gem 'web-console', '3.5.1'
gem 'listen', '3.1.5'
gem 'spring', '2.0.2'
gem 'spring-watcher-listen', '2.0.1'
gem 'tzinfo-data', '1.2017.3'
gem 'devise', '4.4.0'
gem 'jquery-rails', '4.3.1'
gem 'twitter-bootstrap-rails', '4.0.0'
gem 'simple_form', '3.5.0'
gem 'font-awesome-rails', '4.7.0.2'
gem 'momentjs-rails', '2.17.1'
gem 'bootstrap3-datetimepicker-rails', '4.17.47'
gem 'bootstrap-sass', '3.2.0.2'
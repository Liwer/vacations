# Vacations

This is an application in which you can add and track your holidays.  
You have the ability to filter them by year, delete and edit them at will.

## Requirements

Ruby '2.5.0' version;  
Ruby on rails'5.1.4' version;  
Bundler '1.16.1' version;

### To run the application, you need to:

1. Go to the project local and run `bundle` in terminal or iterm, to install gems.
2. Run `rails db:migrate` to add migrations to the database.
3. Run `rails db:seed` to create test users in the database.
4. Run `rails s` to start server, and navigate your browser to: 'localhost:3000'.

### There will be three users in the database
	
1. email: "one@test.com", password: "111222", employment_date: "2016-01-01"
2. email: "two@test.com", password: "111222", employment_date: "2017-01-01"
3. email: "three@test.com", password: "111222", employment_date: "2018-01-01"

You can change the user's data in a file: db/seeds.rb.
After the change run: `rails db:seed`

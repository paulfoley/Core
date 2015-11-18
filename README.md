# Core
Repository for Core Project

----
Ben - 11/17/2015:

I see we created a database writer, excellent! However, it's not quite in line with Rails conventions.

To connect to databases Rails uses a system called ActiveRecord. Basically active record abstracts talking to databases away from SQL and moves it in to objects. For example if we want to create user records in the database we need to create a new model called User at `app/models/user.rb`

First we need to create our database: `rake db:create` which will use the connection setting in `database.yml` and create the database listed for the `development` environment

We also need to create a migration, for example: `rails generate migration CreateUsers`. We need migrations because postgres needs to know what the tables looks like, and since tables change over time, migrations are a central place to keep a running list of changes for your enter schema. Very useful.

Once we have a `users` table and a `User` model we can do stuff like:

```
user = User.new
user.first_name = "Ben"
user.email = "ben.j.jacobson@gmail.com"
user.save # this generates a SQL insert statement
puts user.id
```
```
user = User.find(1) # this generates: SELECT * FROM users WHERE id = 1
user.first_name == "Ben"
```
```
users = User.where(first_name: "Ben") # this generates: SELECT * FROM users WHERE first_name = 'Ben'
users == [...]
```

You should be able to look at the logs and see the SQL active record generated for the code above



# Lists Manage

This is SPA built with Ruby on Rails and ReactJS.

Initially the idea was to create kinda platform for making orders. Which would allow each registered user(can login with Facebook) to add a meal to the active order. Thereby collect meals list to make a real order from restaurant or somewhere else for a group of people: colleagues, classmates, etc.

Currently a person who added an item becomes admin for it. Only he/she can update/remove the item.
It's separates active and archived orders which have states determining whether to modify it(update name, add/remove meal) or not.


#### System dependencies
Ruby 2.3.1
Rials 4.2.6
PostgreSQL database


#### Configuration
Copy `.env-template` to `.env` and save with necessary information. Keep this format:
`SOME_KEY=appropriatevalue `
Copy `config/database.yml` to `config/database.template.yml` providing your postgres username and password.


#### Deployment instructions
```
bundle install && rake db:create db:migrate && rails s
```

##### Production
Currently the application is under major constructions.
If you want to run it please do it in development mode.


#### How to run the test suite
```
rake test
```


#### Author
[Meliq Pilosyan](https://github.com/melopilosyan)


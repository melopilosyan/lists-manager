# Meal Orders


#### System dependencies
Ruby 2.3.1

Rials 4.2.6

PostgreSQL database


#### Configuration
Copy `.env-template` to `.env` in the same directory and save with necessary information. Keep this format:

`SOME_KEY=appropriatevalue `

Create and configure your FaceBook app with steps below.
* Navigate to developers.facebook.com.
* Click “Add new app” under “My Apps” menu item.
* Click “Website” in the dialog.
* Click “Skip and Create ID”.
* Enter a name for your app and choose a category, click “Create”.
* You will be redirected to the app’s page. Click “Show” next to the “App Secret” and enter your password to reveal the key. Copy and paste those keys into your initializer file.
* Open “Settings” section.
* Click “Add Platform” and choose “Website”.
* Fill in “Site URL” (“http://localhost:3000” for local machine) and “App Domains” (must be derived from the Site URL or Mobile Site URL).
* Fill in “Contact E-mail” (it is required to make app active) and click “Save Changes”
* Navigate to the “Status & Review” section and set the “Do you want to make this app and all its live features available to the general public?” switch to “Yes”.

#### How to run the test suite
Simply run `rake test` from application root or subdirectories.


#### Deployment instructions
No specific steps.

`bundle install && rake db:create db:migrate && rails s`

###### Production
Make sure you have postgres installed.

Create and migrate production database: `RAILS_ENV=production rake db:create db:migrate`

Choose your WEB server and configure it to look up for Rails root directory.

Install environment variables from `.env-template` file.

Run `RAILS_ENV=production rake secret` and add SECRETE_KEY_BASE environment variable with the commant output as its value.

Compile assets: `rake assets:precompile`

That's it from Rails side. Check out your WEB server documentation or tutorials how to coonect it with Rails.


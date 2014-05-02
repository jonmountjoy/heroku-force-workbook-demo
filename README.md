A really tiny web application that:

* Performs OAuth with Force.com
* Allows subsequent calls out to Force.com using the awesome [Force.rb](https://github.com/heroku/force.rb)

Read [Integrating Force.com and Heroku Applications](https://devcenter.heroku.com/articles/integrating-force-com-and-heroku-apps) to learn more about the app. 

## Running locally

Create a Salesforce Connected App with a callback URL of `http://localhost:5000/auth/salesforce/callback` (see below)

Create a `.env` file.  Place you Salesforce key and secret from the Salesforce Connected App in the file, together with a cookie secret, like so:

    SECRET=some_random_string
    SALESFORCE_KEY=3M234234234234234324234234324323242334324342343q234Zw.IS
    SALESFORCE_SECRET=524444444444468

Then start the app:

    $ foreman start

And navigate to it in your browser:

    $ http://localhost:5000/    

## Deploying to Heroku

    $ heroku create
    $ git push heroku master

This will create the Heroku app and deploy your code.  The final line of the deploy output will show your app name - for example `http://still-cliffs-2432.herokuapp.com deployed to Heroku`.

Create a new Salesforce Connected App using this app name in the callback URL, for example `https://still-cliffs-2432.herokuapp.com/auth/salesforce/callback`.  (see below).   Note that you have to use HTTPS.

Now set the env vars with the key and secret of the Salesforce app:

    $ heroku config:set SECRET=some_random_string SALESFORCE_KEY=xxxxxx SALESFORCE_SECRET=yyyyy

Visit the application:

    $ heroku open

## Creating a Salesforce key and secret

To create a Salesforce Connected App:

* Log on to salesforce
* Click on your name -> Setup
* Under "App Setup" click Create -> Apps        
* Under "Connected Apps" click "New"
  * Give the app a name, API name, and email address.
  * Enable "Enable OAuth Settings"
  * For "Callback URL" provide the callback URL of your running app.
  * Give the app "Full access" scope
  * The "Consumer Key" and "Consumer Secret" values should be placed in the `.env` file as above.

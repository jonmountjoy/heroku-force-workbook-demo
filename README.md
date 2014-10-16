A tiny web application that:

* Performs OAuth with Force.com
* Allows subsequent calls out to Force.com using the [Force.rb](https://github.com/heroku/force.rb) library.

Read [Integrating Force.com and Heroku Applications](https://devcenter.heroku.com/articles/integrating-force-com-and-heroku-apps) to learn more about the app.

## Creating a Salesforce key and secret

You need a key/secret in order to integrate with a Salesforce app.  Do this by creating a Salesforce Connected App:

* Log on to salesforce
* Click on your name -> Setup
* Under "App Setup" click Create -> Apps
* Under "Connected Apps" click "New"
  * Give the app a name, API name, and email address.
  * Enable "Enable OAuth Settings"
  * For "Callback URL" provide `http://localhost:5000/auth/salesforce/callback`
  * Give the app "Full access" scope
  * The "Consumer Key" and "Consumer Secret" values should be placed in the `.env` file as above.


## Deploying to Heroku

1. Push the button: [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

2. Enter the Salesforce Key and Secret when prompted (see below)
3. Make a note of the app name - for example, `obscure-plains-5853`.
4. Edit the Connected App to update the callback URL to correspond to your app.  So for example, if your app name was `obscure-plains-5853` then the callback URL should be `https://obscure-plains-5853.herokuapp.com/auth/salesforce/callback`.
5. Save the new configuration, wait a minute, then access your Heroku app.


## Running locally

Create a `.env` file.  Place you Salesforce key and secret from the Salesforce Connected App in the file, together with a cookie secret, like so:

    SECRET=some_random_string
    SALESFORCE_KEY=324323242334324342343q234Zw.IS
    SALESFORCE_SECRET=524444444444468

Then run bundle to install all gems for this app:

    $ bundle

Make sure that your Connected App uses localhost as its callback URL as noted above.  Set it to http://localhost:5000/auth/salesforce/callback

Then start the app:

    $ foreman start

And navigate to it in your browser:

    $ http://localhost:5000/

## Deploying to Heroku from the command line

    $ heroku create
    $ git push heroku master

This will create the Heroku app and deploy your code.  The final line of the deploy output will show your app name - for example `http://still-cliffs-2432.herokuapp.com deployed to Heroku`.

Modify the Salesforce Connected App using this app name in the callback URL, for example `https://obscure-plains-5853.herokuapp.com/auth/salesforce/callback`.   Note that you have to use HTTPS.

Now set the env vars with the key and secret of the Salesforce app:

    $ heroku config:set SECRET=some_random_string SALESFORCE_KEY=xxxxxx SALESFORCE_SECRET=yyyyy

Visit the application:

    $ heroku open


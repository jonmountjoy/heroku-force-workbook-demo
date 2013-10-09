A really tiny web application that:

* Performs OAuth with Force.com
* Allows subsequent calls out to Force.com using the awesome [Force.rb](https://github.com/heroku/force.rb)

## Running locally

Create a `.env` file.  Place you Salesforce key and secret in the file, like so:

    SALESFORCE_KEY=3M234234234234234324234234324323242334324342343q234Zw.IS
    SALESFORCE_SECRET=524444444444468

Then start the app:

    $ foreman start

And navigate to it in your browser:

    $ http://localhost:5000/    

## Creating a Salesforce key and secret

If you don't yet have key and secret, do the following:

* Log on to salesforce
* Click on your name -> Setup
* Under "App Setup" click Create -> Apps        
* Under "Connected Apps" click "New"
  * Give the app a name, API name, and email address.
  * Enable "Enable OAuth Settings"
  * For "Callback URL" give `http://localhost:5000/auth/salesforce/callback`
  * Give the app "Full access" scope
  * The "Consumer Key" and "Consumer Secret" values should be placed in the `.env` file as above.
# fyber_offers [![Build Status](https://semaphoreci.com/api/v1/projects/3e1ef652-36a4-47cd-9233-68848cbaa00d/445255/badge.svg)](https://semaphoreci.com/philipefarias/fyber_offers)
Web app that consumes the Fyber Offer API and renders its responses.

## Instructions to run
First make sure all the dependencies are installed. This are the main ones:

- Ruby 2.2.2
- Bundler

Then install the rest using bundler:

    $ bundle

After that, make sure all the tests are passing:

    $ rake

Inform your API key and edit config.yml for the API url and default params:

    $ cp .env.sample .env
    $ <editor_of_choice> .env
    $ <editor_of_choice> config.yml

Start the web server (any rack compatible should do):

    $ rackup
    
And finally open it in the browser. For Webrick (on OSX) this should open it:

    $ open http://localhost:9292

## Design notes

### Spike
I started developing a simple script that will make the resquest.
It is just a proof of concept to get a better understanding of the problem.

First, I need to understand what this api is about and what kind of params it accepts and expect.
For this, a reading of the docs and a simple ruby script will do.

### First iteration
After discovering some basic things about the API and getting the response now I can begin to think about the app.

In the beggining there will be only 3 classes:
- Client: will handle the request
- Offer: a simple mapper to the json offer
- Web: will render the results


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

    $ cp .test.env .env
    $ <editor_of_choice> .env
    $ <editor_of_choice> config.yml

Start the web server (any rack compatible should do):

    $ bundle exec thin start
    
And finally open it in the browser. For Thin (on OSX) this should open it:

    $ open http://localhost:3000

## Design notes

### Spike
I started developing a simple script that will make the resquest.
It is just a proof of concept to get a better understanding of the problem.

First, I need to understand what this api is about and what kind of params it accepts and expect.
For this, a reading of the docs and a simple ruby script will do.

### First iteration (what was expected)
After discovering some basic things about the API and getting the response now I was ready to think about the app.

In the beggining there would be only 3 classes:

- Client: will handle the request
- Offer: a simple mapper to the json offer
- Web: will render the results

### First iteration (what really happened)
So, soon I discovered that wasn't a need for the Offer class yet.
I focused on the client and web then.

Because I choose to make the app as barebones as possible in the beginning this took a lot longer than expected.
In general, I wanted to keep its classes really simple and testable.
But without all that help that usually we got from Rails there was too much time spent on little things. 

In the first days I wanted to use rack middlewares to deal with the user interaction.

Wasn't a wise choise due to the time constraints.
Sinatra was used as a stand in and the kept the ball rolling (not as fast as it should be, I admit).

### Everything since then
The app was divided in two major parts: the Web part and the API part, with a help from the Utils module (for some of the little things).

The API responsibility is to talk, well, to the Fyber API and parse its results.
The Web responsibility is to interact with the user and the API client.

Both are kept somehow isolated. The objective is to treat as they are separated libraries, with a single point of entry each.
There may be some duplicated logic because of that but this way they're easy to reason about (and test).

Some random details and thoughts:

- Minitest is the best test library with the worst output there is. Man, that was confusing sometimes...
- The CSS framework Materialize is being used because I wanted to make it pretty and didn't want to deal with all the CSS nonsense.
But I had to deal with all the framework nonsense and it still isn't pretty. Heh
- Quite late in development I choose to swap the Net::HTTP client for Curb, mainly for the (easy) keep-alive connection and to write an adapter class. :D
- I hope that the config part isn't confusing. I was struggling a little for what should go into the git repo.
Initially everything was out but then I decided that only the API key should be left out (hopping that this was the right call).
- When was time to deploy, I setup the project in SemaphoreCI and discovered that my tests was kinda brittle because of the `Time.local` call.
- When it was finally deployed to Heroku there was more broken things to fix. Now it seems ok and its configured to deploy (github) master as soon as the build is green.
So, kids, deploy soon, deploy often ;)
- It is really fun to write small, easily testable, classes. The opposite, not so fun.
- I might have gone this route (barebones app) because I was tired of dealing only with Rails (at my daily work) and was eager to do something different...
Not sure if it was really worth it, taking into account that I probably lost all my (job) points because of the long time it took to finish... At least it was fun, right? ;)


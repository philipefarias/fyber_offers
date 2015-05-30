# fyber_offers
Web app that consumes the Fyber Offer API and renders its responses.

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


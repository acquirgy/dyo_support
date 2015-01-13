# ThermoSpas DYO Support

The support application for [ThermoSpas
DYO](https://github.com/acquirgy/thermospas-dyo).

This application is built in Ruby with [Sinatra](http://www.sinatrarb.com). It is a
basic HTTP API that handles the following:

- Uploading image data sent from via a POST request from the Ember.js
  application to Cloudinary
- Displaying an HTML page with any given Cloudinary image based on the params.
  This allows social sharing with og tags to work as expected. This HTML page
  redirects to the ThermoSpas home page.

## Developing

Follow these steps to get the app working locally:

1. Install Ruby 2.1.3, which is specified in the `Gemfile`
1. Clone the repo: `git@github.com:acquirgy/dyo_support.git`
1. Move into the directory: `cd dyo_support`
1. Install the dependencies: `bundle install`
1. Run the app: `ruby app.rb`
1. View [http://localhost:4567/api/](http://localhost:4567/api/) to make sure it
   is working as expected

When developing locally, the `/api/` prefix is added to routes to ensure that it
is reachable at the correct endpoints the Ember.js app expects.

## Configuring

Cloudinary is a service used for handling image uploads that dyo_support uses. It is configured in the
`app.rb`.

## Hosting

The app is currently hosted on Heroku as
[`thermospas-dyo-support`](https://thermospas-dyo-support.herokuapp.com/). If
the URL changes,
be sure to change the `API_URL` in the `thermospas-dyo` Heroku app.

## Deploying

1. Install the [Heroku toolbelt](https://toolbelt.heroku.com/)
2. Add the Heroku Git remote: `git@heroku.com:thermospas-dyo-support.git`
3. Push the `master` branch to the Heroku remote: `git push heroku master`

## Social Sharing Configuration

The information for social sharing with og tags are set in
`views/cloudinary.erb`. Adjust the `og:title`, `og:description`, and `og:image`
to change what gets displayed for social sharing with sites that use the og
tags.

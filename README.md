# Express Base

### (c) Aaron Zampaglione 2012

This is a base application that uses Express, Mocha, Soda (Selenium), Docco, RequireJS (+ i18n), jQuery, Bootstrap, Backbone, and Less.

The files are developed in CoffeeScript and then use cake to compile the server side source in real time and CodeKit to compile JavaScript, Stylesheets, and Images to the "/public" folder in real time.

** This is not intended to be a framework.  This project is just a clean implementation using all of today's bleeding edge web development technologies and practices. **

## Features
- Developed in CoffeeScript.
- Every controller/route is RESTful.
- Internationalization (i18n).
- Themes.
- Documentation via Docco.
- Unit testing via Mocha.
- Functional testing via Soda (Selenium).
- Adheres with [Yahoo's Performance Rules](http://developer.yahoo.com/performance/rules.html) (e.g. cookie-free-domains, minified images/javascripts/stylesheets, sprites, etc.).
- Bootstrap based.
- Modular front-end and back-end development with RequireJS.

## Install
After pulling the master branch, install all the dependencies and go!

    npm install -d

## Usage

### Production
Running in production is pretty simple... just run server.js!

    node server.js

### Development
While developing, turn on cake dev mode to automatically convert your .coffee files into .js files and place them in the "/app" folder.

    ./cake dev

### Testing

#### Functional
Still under development.

#### Unit
Still under development.

## Tools
- [CodeKit](http://incident57.com/codekit)

## Resources
- [CoffeeScript](http://coffeescript.org) v*
- [express](http://expressjs.com) v3.x
- [mocha](http://visionmedia.github.com/mocha) v*
- [soda](http://learnboost.github.com/soda) v*
- [Selenium](http://seleniumhq.org) v*
- [docco](http://jashkenas.github.com/docco) v*
- [less](http://lesscss.org) v*
- [requirejs](http://requirejs.org) v2.1.1
- [jQuery](http://jquery.com) v1.8.2
- [Bootstrap](http://twitter.github.com/bootstrap) v2.2.1
- [Backbone](http://backbonejs.org) v0.9.2
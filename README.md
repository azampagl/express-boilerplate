# Express Base

### MIT License
### (c) 2012-present Aaron Zampaglione <azampagl@azampagl.com>

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
While developing, turn on cake dev mode to automatically convert your .coffee files in the "/src" directory into .js files in the "/app" folder.

    ./cake dev

In addition, make sure that CodeKit is activated on your "/public/default" folder (or whatever theme is currently activated).  CodeKit will automatically convert CoffeeScript files to minified JavaScript ("/public/{theme}/coffee" => "/public/{theme}/js") and Less files to normal minified stylesheets ("/public/{theme}/less" => "/public/{theme}/css").

### Testing
The application is setup to execute both unit (+supertest) and functional tests.  To simply run all of the tests, run the following command in the root of the application:

    ./cake test

#### Functional
Still under development.

Before running these tests, don't forget to have selenium running in the background!

To run all functional tests:

    ./cake test functional

To run an individual functional test:

    ./cake test functional index

To run select functional tests:

    ./cake test functional index,i18n

#### Unit
Still under development.

To run all unit tests:

    ./cake test unit

To run an individual unit test:

    ./cake test unit routes/foo

To run select unit tests:

    ./cake test unit routes/foo,routes/i18n

### Tips

#### 1. Adding javascripts and stylesheets on a per-page basis.
#### 2. Adding "global" javascript variables.

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
- [requirejs](http://requirejs.org) v2.1.2
- [jQuery](http://jquery.com) v1.8.2
- [Bootstrap](http://twitter.github.com/bootstrap) v2.2.1
- [Backbone](http://backbonejs.org) v0.9.2
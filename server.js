/**
 * Main entry point to execute the application.
 *
 * @license MIT
 * @copyright (c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>
 */
path = require('path');
requirejs = require('requirejs');

// Setup requirejs.
requirejs.config({
  baseUrl: path.resolve(__dirname + '/app'),
  nodeRequire: require
});

// Require our app, initialize, and run.
requirejs(['app'], function(App) {
  App(function(app) {
    var port = process.env.PORT || process.env.VMC_APP_PORT || 3000;
	app.listen(port);
  });
});
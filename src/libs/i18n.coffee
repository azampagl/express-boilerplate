# *MIT License*
#
# *(c) 2012-Present Aaron Zampaglione <azampagl@azampagl.com>*
#
# Internationalization support based on requirejs i18n plugin.
#

#
define ['async', 'fs', 'underscore'], (async, fs, _) ->

  #
  # # _cache #
  # 
  # Cache for all i18n strings loaded.
  #
  _cache = {}

  #
  # # _cookie #
  #
  # Cookie settings.
  #
  _cookie = 
    key: 'lang'
    httpOnly: false

  #
  # # cookie() #
  #
  # Gets/Sets the desired language into the cookies.
  #
  cookie: (req, res, lang, domain) ->
    # If res and lang are given, we are setting the cookie.
    if res and lang
      # Set the domain to the current host, if a domain is not provided.
      domain = req.get('host').replace(/\:.+/, '') unless domain
      # Set the cookie.
      res.cookie _cookie.key, lang,
        domain: domain
        httpOnly: _cookie.httpOnly

      return lang

    # res and lang were not provided, we are getting the current cookie value.
    req.cookies[_cookie.key]

  #
  # # locale() #
  #
  # Determines the locale of the current request in the following order:
  #
  #  1. Cookie.
  #  2. Accepted-Languages [See req API](http://expressjs.com/api.html#req.acceptedLanguages).
  #  3. Default to en_US.
  #
  locale: (req) ->
    @cookie(req) or req.acceptedLanguages[0] or 'en-us'

  #
  # # load() #
  # 
  # Loads the locales in a given file.
  #
  load: (locale, file, cb) ->
    fs.exists requirejs.toUrl('i18n/' + file), (exists) ->
      if exists
        requirejs
          locale: locale
          context: locale
          baseUrl: requirejs.toUrl('./')
        , ['i18n!i18n/' + file], cb
      else
        cb {}

  #
  # # middleware() #
  # 
  # Express middleware to initialize a locale.
  #
  #     app.use i18n.middleware()
  #
  middleware: ->
    (req, res, next) =>
      # Set the default locale.
      req.locale = locale = @locale(req)

      # Use cached common, if available.
      if _cache[locale] and _cache[locale]['common']
        res.locals.strings = _cache[locale]['common']
        return next()

      @load locale, 'routes/nls/common', (strings) ->
        # Put the most common strings in our response.
        res.locals.strings = strings
        # Cache common strings.
        _cache[locale] = _cache[locale] or {}
        _cache[locale]['common'] = strings

        next()

  #
  # # view() #
  # 
  # Load locale based strings into response.
  #
  #     i18n.view('i18n/routes/nls/index')
  #
  #     i18n.view(['i18n/models/nls/user', 'i18n/routes/nls/index'])
  #
  view: (files) ->    
    # Make sure we are using an array.
    files = [files] unless _.isArray(files)
    (req, res, next) =>
      locale = req.locale
      res.locals.strings = res.locals.strings or {}

      # Hash to determine where the strings are stored in cache.
      hash = files.join('')
      
      # Check if we already cached for this locale.
      if _cache[locale] and _cache[locale][hash]
        res.locals.strings = _.extend(res.locals.strings, _cache[locale][hash])
        return next()

      # Local strings for this function call.
      _strings = {}

      # For each file provided, merge it into the strings attribute.
      async.forEachSeries files, ((file, subnext) =>

        # Check for a namespace.
        namespace = undefined
        unless _.isString(file)
          namespace = file.namespace
          file = file.file

        @load locale, file, (strings) ->
          if namespace
            _strings[namespace] = _.extend(_strings[namespace] or {}, strings)
          else
            _strings = _.extend(_strings, strings)

          subnext()

      ), (err) ->
        
        # Store in cache for quick reference later.
        _cache[locale][hash] = _strings
        # Extend the current strings in the response.
        res.locals.strings = _.extend(res.locals.strings, _strings)

        next()
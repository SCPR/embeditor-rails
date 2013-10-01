class Embeditor.Embed.Embedly extends Embeditor.Embed.Oembed
    # This object should hold any keys that we want to
    # send to the API. Any key not in this object will
    # be ignored as a data attribute.
    @QueryDefaults =
        maxheight   : 450

    @PluginDefaults =
        method      : "after"
        className   : Embeditor.wrapperClass
        endpoint    : 'oembed'
        # Key must be specified

    constructor: (@element, options={}) ->
        dataOptions = {}

        for key,val of @element.data()
            # Make sure we care about this attribute
            if Embedly.DefaultOptions[key]
                dataOptions[key] = val

        # We're combining a few things (in order of precedence):
        # 1. The `data-attributes` of the placeholder,
        # 2. The `Embedly`-specific options specified at Embeditor
        #    initialization,
        # 3. The global options specified at Embeditor initialization,
        # 4. This adapter's default options (fallback options).
        @queryParams = _.defaults(dataOptions, 
            options['Embedly']['query'], options['query']
            Embedly.QueryDefaults)

        @pluginOptions = _.defaults(options['Embedly']['plugin'],
            Embedly.PluginDefaults)

        super


    swap: ->
        params = @_buildEmbedlyParams()
        @element.embedly(params)


    _buildEmbedlyParams: ->
        if @embedlyParams
            return @embedlyParams

        @embedlyParams = _.extend(
            @pluginOptions,
            query : @queryParams)

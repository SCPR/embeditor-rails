class Embeditor.Adapters.Embedly extends Embeditor.Adapters.Oembed
    # This object should hold any keys that we want to
    # send to the API. Any key not in this object will
    # be ignored as a data attribute.
    @QueryDefaults =
        maxheight   : 450

    @PluginDefaults =
        method      : "after"
        className   : Embeditor.DefaultOptions.wrapperClass
        endpoint    : 'oembed'
        # Key must be specified

    constructor: (@element, options={}) ->
        @dataOptions = @_extractData()
        @queryParams = @_buildParams(@dataOptions, options)

        @pluginOptions = _.defaults(options['Embedly']?['plugin'],
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

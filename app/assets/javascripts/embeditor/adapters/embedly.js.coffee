# This doesn't inherit from Adapters.Oembed because the Embedly plugin
# handles most of that stuff on its own.
class Embeditor.Adapters.Embedly extends Embeditor.Adapter
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
        pluginOpts = options['Embedly']?['plugin'] or {}
        @pluginOptions = _.defaults(pluginOpts, Embedly.PluginDefaults)

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

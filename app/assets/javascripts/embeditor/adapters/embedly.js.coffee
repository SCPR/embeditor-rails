# This doesn't inherit from Adapters.Oembed because the Embedly plugin
# handles most of that stuff on its own.
class Embeditor.Adapters.Embedly extends Embeditor.Adapter
    className: "Embedly"

    # Map `data-placement` to Embedly `method` parameter options.
    @MethodMap =
        replace     : 'replace'
        before      : 'before'
        after       : 'after'

    # This object should hold any keys that we want to
    # send to the API. Any key not in this object will
    # be ignored as a data attribute.
    @QueryDefaults =
        maxheight   : 450

    @PluginDefaults =
        method      : 'after'
        className   : Embeditor.DefaultOptions.wrapperClass
        endpoint    : 'oembed'
        # Key must be specified


    constructor: (@element, @options={}) ->
        pluginOpts = @options['Embedly']?['plugin']
        @pluginOptions = _.defaults(pluginOpts, Embedly.PluginDefaults)

        super


    swap: ->
        params = @_buildEmbedlyParams()
        console.log params
        @element.embedly(params)


    _buildEmbedlyParams: ->
        if @embedlyParams
            return @embedlyParams

        # Use `data-placement` as the embedly method parameter
        @embedlyParams = _.extend(
            _.defaults({
                method : Embedly.MethodMap[@display.placement]
            }, @pluginOptions),
            query : @queryParams)

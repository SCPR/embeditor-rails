class Embeditor.Embed.Embedly extends Embeditor.Embed.Oembed
    # This object should hold any keys that we want to
    # send to the API. Any key not in this object will
    # be ignored as a data attribute.
    @queryDefaults =
        maxheight: 450

    @embedlyDefaults =
        key         : "0cb3651dde4740db8fcb147850c6b555"
        method      : "before"
        className   : Embeditor.Embed.wrapperClass
        endpoint    : 'oembed'


    constructor: (@element) ->
        super
        data = {}

        for key,val of @element.data()
            # Make sure we care about this attribute
            if Embedly.queryDefaults[key]
                data[key] = val

        @queryParams = _.defaults data, Embedly.queryDefaults


    swap: ->
        params = @_buildEmbedlyParams(@queryParams)
        @element.embedly(params)


    _buildEmbedlyParams: (queryParams) ->
        if @embedlyParams
            return @embedlyParams

        @embedlyParams = _.extend(
            Embedly.embedlyDefaults,
            query : queryParams)

class Embeditor.Embed.Oembed extends Embeditor.Embed.Adapter
    constructor: (@element) ->
        super
        data = {}

        for key,val of @element.data()
            # Make sure we care about this attribute
            if Oembed.queryDefaults[key]
                data[key] = val

        @queryParams = _.defaults data, Oembed.queryDefaults

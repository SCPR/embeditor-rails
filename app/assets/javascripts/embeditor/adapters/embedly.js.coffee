class Embeditor.Adapters.Embedly extends Embeditor.Adapters.Oembed
    className: "Embedly"

    @Endpoint = "https://api.embed.ly/1/oembed"

    # This object should hold any keys that we want to
    # send to the API. Any key not in this object will
    # be ignored as a data attribute.
    @QueryDefaults =
        maxheight   : null
        maxwidth    : 650 # Without this, height is just at the maximum.

class Embeditor.Adapters.Polldaddy extends Embeditor.Adapters.Oembed
    className: "Polldaddy"

    @Path = "http://polldaddy.com/oembed/" # Doesn't work w/o trailing slash...

    @QueryDefaults =
        maxwidth  : 620
        maxheight : 550
        format    : 'json'


    constructor: (@element, @options={}) ->
        super

        # Work around a polldaddy bug where the oembed endpoint doesn't
        # properly recognize SSL URL's given to it.
        @href = Embeditor.Utility.convertProtocolToHttp(@href)

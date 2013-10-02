class Embeditor.Adapters.Polldaddy extends Embeditor.Adapters.Oembed
    @Path = "http://polldaddy.com/oembed"

    @QueryDefaults =
        maxwidth    : 510
        maxheight   : 374
        format      : 'json'

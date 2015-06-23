class Embeditor.Adapters.DocumentCloud extends Embeditor.Adapters.Oembed
    className: "DocumentCloud"
    @Endpoint = "http://www.documentcloud.org/api/oembed.json"

    @QueryDefaults =
        maxheight   : 700
        responsive  : true
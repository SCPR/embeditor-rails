class Embeditor.Adapters.FireTracker extends Embeditor.Adapters.Oembed
    className: "FireTracker"

    @Endpoint = "http://firetracker.scpr.org/oembed"

    @QueryDefaults =
        maxwidth    : 510
        maxheight   : 374
        format      : 'json'

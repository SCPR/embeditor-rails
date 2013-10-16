class Embeditor.Adapters.GoogleFusion extends Embeditor.Adapters.StaticTemplate
    className: "GoogleFusion"

    @Template = Embeditor.Template('google_fusion')

    @QueryDefaults =
        maxwidth  : 620
        maxheight : 550

    @Matchers = []

    swap: ->
        @embed GoogleFusion.Template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
            url         : @href

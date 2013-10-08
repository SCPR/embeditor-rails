class Embeditor.Adapters.Twitter extends Embeditor.Adapters.StaticTemplate
    className: "Twitter"

    @Template = Embeditor.Template('twitter')

    # Twitter doesn't give a damn about you or your dimensions.
    @QueryDefaults = {}

    # For twitter, we just use the full URL, so no matchers are needed.
    @Matchers = []


    swap: ->
        @embed Twitter.Template(url : @href)

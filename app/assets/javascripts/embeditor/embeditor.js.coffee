window.Embeditor = {
    Adapters : {}

    DefaultAdapters :
        'youtube'       : 'Embedly'
        'vimeo'         : 'Embedly'
        'brightcove'    : 'Brightcove'
        'ustream'       : 'Embedly'
        'livestream'    : 'Embedly'
        'vine'          : 'Embedly'
        'googlemaps'    : 'Embedly'
        'googlefusion'  : 'GoogleFusion'
        'scribd'        : 'Embedly'
        'documentcloud' : 'DocumentCloud'
        'polldaddy'     : 'Polldaddy'
        'facebook'      : 'Embedly'
        'storify'       : 'Storify'
        'coveritlive'   : 'CoverItLive'
        'rebelmouse'    : 'RebelMouse'
        'firetracker'   : 'FireTracker'
        'twitter'       : 'Twitter'
        'instagram'     : 'Instagram'
        'soundcloud'    : 'Embedly'
        'spotify'       : 'Embedly'
        'ranker'        : 'Ranker'
        'other'         : 'Embedly'

    TemplatePath : 'embeditor/templates/'

    Template : (template) ->
        JST[@TemplatePath + template]

    DefaultOptions :
         # Adapter that gets used when the service isn't recognized
        defaultAdapter      : 'Embedly'
        # Service that gets used when the `data-service` attribute is missing
        defaultService      : 'other'
        # The class that the embed placeholders have
        placeholderClass    : "embed-placeholder"
        # The class the embed's wrapper should be given
        wrapperClass        : "embed-wrapper"
        # The element name which should be wrapped around all embed.
        # TODO: Allow setting this to "false" for no wrapper.
        wrapperElement      : "div"
        # Default embed placement, if a placement is somehow missing or
        # it doesn't exist in the PlacementFunctions object.
        defaultPlacement    : 'after'

    # jQuery function mapping for embed placement,
    # relative to the placeholder link.
    #
    # Keys are the `data-placement` attribute, and values are the
    # jQuery functions.
    PlacementFunctions :
        before          : 'before'
        after           : 'after'
        replace         : 'replaceWith'

}


class Embeditor.Base
    constructor: (options={}, adapters={}) ->
        @options    = _.defaults(options, Embeditor.DefaultOptions)
        @adapters   = _.defaults(adapters, Embeditor.DefaultAdapters)

        @placeholders = []
        @links = $(@_classify @options.placeholderClass)

        @findEmbeds()


    swap: ->
        placeholder.swap() for placeholder in @placeholders


    findEmbeds: ->
        for link in @links
            link = $(link)

            # If "service" is blank in the CKEditor dialog, then it will
            # omit that data-attribute from the tag, and therefore
            # be undefined. In this scenario, we want to use the default
            # service as a fallback.
            #
            # If "service" is present but has no match in the Adapters object,
            # then we want to use the default handler as a fallback.
            service         = link.data('service') || @options.defaultService
            adapterName     = @adapters[service] || @options.defaultAdapter
            adapter         = Embeditor.Adapters[adapterName]

            return if not adapter

            placeholder = new adapter(link, @options)
            @placeholders.push(placeholder)


    _classify: (str) ->
        "." + str

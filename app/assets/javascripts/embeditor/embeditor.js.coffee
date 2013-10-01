class Embeditor
    @placeholderFinder  = "embed-placeholder"
    @wrapperClass       = "embed-wrapper"

    @embedHandlers =
        'youtube'       : 'Embedly'
        'vimeo'         : 'Embedly'
        # 'brightcove'    : 'Embedly'
        'ustream'       : 'Embedly'
        'vine'          : 'Embedly'
        # 'googlemaps'    : 'Embedly'
        'scribd'        : 'Embedly'
        # 'documentcloud' : 'DocumentCloud'
        # 'polldaddy'     : 'Embedly'
        'facebook'      : 'Embedly'
        # 'storify'       : 'Embedly'
        'coveritlive'   : 'CoverItLive'
        # 'rebelmouse'    : 'RebelMouse'
        # 'firetracker'   : 'FireTracker'
        # 'twitter'       : 'Embedly'
        'instagram'     : 'Embedly'
        'soundcloud'    : 'Embedly'
        'spotify'       : 'Embedly'
        'other'         : 'Embedly'

    @defaultHandler = 'Embedly'
    @defaultService = 'other'


    @defaults =
        maxheight   : 450


    constructor: (options={}) ->
        @options        = _.defaults options, @defaults
        @placeholders   = []

        @links  = $(@_classify Embeditor.placeholderFinder)

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
            # If "service" is present but has no match in the Handlers object,
            # then we want to use the default handler as a fallback.
            service = link.data('service') || Embeditor.defaultService
            handler = Embeditor.embedHandlers[service] || Embeditor.defaultHandler

            placeholder = new Embeditor[handler](link)
            @placeholders.push(placeholder)


    _classify: (str) ->
        "." + str

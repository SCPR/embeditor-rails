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
        'scribd'        : 'Embedly'
        # 'documentcloud' : 'DocumentCloud'
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
        'other'         : 'Embedly'

    TemplatePath : 'embeditor/templates/'

    Template : (template) ->
        JST[@TemplatePath + template]

    DefaultOptions :
        defaultAdapter      : 'Embedly' # Adapter that gets used when the service isn't recognized
        defaultService      : 'other'   # Service that gets used when the `data-service` attribute is missing
        placeholderClass    : "embed-placeholder" # The class that the embed placeholders have
        wrapperClass        : "embed-wrapper" # The class the embed's wrapper should be given
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
            service = link.data('service') || @options.defaultService
            adapterName = @adapters[service] || @options.defaultAdapter
            adapter = Embeditor.Adapters[adapterName]

            return if not adapter

            placeholder = new adapter(link, @options)
            @placeholders.push(placeholder)


    _classify: (str) ->
        "." + str

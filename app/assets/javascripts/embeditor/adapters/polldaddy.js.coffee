class Embeditor.Adapters.Polldaddy extends Embeditor.Adapters.StaticTemplate
    className: "Polldaddy"

    # We have to figure out the template dynamically.
    @Template = null

    @QueryDefaults =
        maxwidth  : 620
        maxheight : 550
        format    : 'json'

    @Matchers = [
        new RegExp(/https?:\/\/([^\/]+)\/([^\/]+)\/([^\/]+)\/?/)
    ]


    swap: ->
        match = @_parseUrl()
        return false if not match

        domain  = match[1]
        type    = match[2]
        id      = match[3]

        template = @_findTemplate(type)

        @embed template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
            domain      : domain
            id          : id


    _findTemplate: (type) ->
        template = switch type
            when 's' then 'polldaddy_survey'
            when 'poll', 'p' then 'polldaddy_poll'

        Embeditor.Template(template)

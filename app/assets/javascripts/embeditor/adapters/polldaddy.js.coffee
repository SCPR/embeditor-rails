class Embeditor.Adapters.Polldaddy extends Embeditor.Adapters.StaticTemplate
    className: "Polldaddy"

    # We have to figure out the template dynamically.
    @Template = null

    @QueryDefaults =
        maxwidth  : 620
        maxheight : 550

    @Matchers = [
        new RegExp /https?:\/\/([^\/]+)\/([^\/]+)\/([^\/]+)\/?/i
    ]


    swap: ->
        match = @_parseUrl()
        return false if not match

        domain  = match[1]
        type    = match[2]
        id      = match[3]

        template = @_findTemplate(type)

        oldDocumentWrite = document.write
        document.write = (html) => @wrapper.append(html)

        @embed template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
            domain      : domain
            id          : id

        setTimeout ->
            document.write = oldDocumentWrite
        , 500

    _findTemplate: (type) ->
        template = switch type
            when 's' then 'polldaddy_survey'
            when 'poll', 'p' then 'polldaddy_poll'

        Embeditor.Template(template)

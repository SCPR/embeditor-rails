class Embeditor.Adapters.Brightcove extends Embeditor.Adapters.StaticTemplate
    className: "Brightcove"

    @Template = Embeditor.Template('brightcove')

    @QueryDefaults =
        maxwidth  : 620
        maxheight : 550

    @Matchers = [
        new RegExp /bcpid(\d+)\?bckey=([^&]+)/i
    ]

    swap: ->
        match = @_parseUrl()
        return false if not match

        playerId  = match[1]
        playerKey = match[2]

        @embed Brightcove.Template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
            playerId    : playerId
            playerKey   : playerKey

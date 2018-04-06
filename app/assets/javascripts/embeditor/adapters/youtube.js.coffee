class Embeditor.Adapters.YouTube extends Embeditor.Adapters.StaticTemplate
    className: "YouTube"

    @VideoTemplate    = Embeditor.Template('youtube')
    @PlaylistTemplate = Embeditor.Template('youtube_playlist')

    @QueryDefaults =
        maxwidth  : 560
        maxheight : 315

    @Matchers = [
        /(youtu\.be\/|youtube\.com\/(watch\?(.*&)?v=|(embed|v)\/))([^\?&"'>]+)/i,
        /(youtu\.be\/|youtube\.com\/(watch\?(.*&)?list=|(embed|v)\/))([^\?&"'>]+)/i
    ]

    swap: ->
        match = @_parseUrl()
        return false if not match

        id  = match[5]

        template = if id.length > 11 then YouTube.PlaylistTemplate else YouTube.VideoTemplate

        @embed template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
            id          : id


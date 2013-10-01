class Embeditor.Embed.CoverItLive extends Embeditor.Embed.Adapter
    @template = JST[scpr.Embed.Adapter.TemplatePath + 'cover_it_live_embed']

    swap: ->
        re          = new RegExp "/altcast_code=([^/]+)/", "gi"
        event_id    = re.exec(@href)[1]
        @element.replaceWith CoverItLive.template(event_id: event_id)

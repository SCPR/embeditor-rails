class Embeditor.Embed.Adapter
    @TemplatePath = "embed/templates/"

    constructor: (@element) ->
        @href = @element.attr('href')


    swap: ->
        return

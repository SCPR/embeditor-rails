class Embeditor.Embed.Adapter
    @TemplatePath = "embed/templates/"

    constructor: (@element, options={}) ->
        @href = @element.attr('href')


    swap: ->
        return

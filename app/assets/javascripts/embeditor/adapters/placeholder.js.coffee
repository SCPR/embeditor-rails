# Each placeholder should define at least the swap() method, and
# probably the constructor too.
class scpr.Embed.Placeholder
    @TemplatePath = "embed/templates/"

    constructor: (@element) ->
        @href = @element.attr('href')


    swap: ->
        return

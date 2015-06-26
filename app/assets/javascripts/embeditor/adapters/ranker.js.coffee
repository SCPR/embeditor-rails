class Embeditor.Adapters.Ranker extends Embeditor.Adapters.Oembed
    className: "Ranker"
    @Endpoint = "http://widget.ranker.com/oembed"

    swap: ->
      matcher = /\/(\d+)/
      id = matcher.exec(@href)[1]

      $.ajax
          url         : "#{@adapter.Endpoint}/#{id}"
          type        : 'GET'
          dataType    : 'json'
          data        :  _.extend(@queryParams)

          success: (data, textStatus, jqXHR) =>
              @embedData(data)

          error: (jqXHR, textStatus, errorThrown) =>
              console.log('[embeditor oembed] error.', jqXHR)
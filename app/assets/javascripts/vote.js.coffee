$ ->
  $('body')
    .on('ajax:success', '.js-vote-count', (event, data, status, xhr) ->
      $(@).siblings('.js-vote-score').find('.badge').text(data)
      console.log(data)
    ).on('ajax:error', '.js-vote-count', (xhr, status, error) ->
      #console.log(status)
    ).on('ajax:complete', '.js-vote-count', (event, xhr, status) ->
      #console.log(status)
    )

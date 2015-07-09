$ ->
  $('body')
    .on 'ajax:success', (event, data, status, xhr) ->
      console.log('success')
      console.log(data)
    .on 'ajax:error', '.js-vote-count', (xhr, status, error) ->
      console.log(error)
    .on 'ajax:complete', (event, xhr, status) ->
      console.log('complete')
      console.log(status)

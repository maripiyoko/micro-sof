$ ->
  $('body')
    .on('change', '.js-update-preview', ->
      text = $(@).val()
      $.ajax(
        type: 'GET',
        url: '/markdown_preview',
        data: { text: text }
      )
    )

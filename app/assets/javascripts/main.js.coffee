$ ->
  $(document).on "ajax:success", "#comment_block form[data-remote]", (e, data, status, xhr) ->
    $('#comment_block').replaceWith(data)
  $(document).on "ajax:success", "#like_block form[data-remote]", (e, data, status, xhr) ->
    $('#like_block').replaceWith(data)
  $(document).on "ajax:success", "#vote_block form[data-remote]", (e, data, status, xhr) ->
    $('#vote_block').replaceWith(data)

  $(document).on "click", "article.category", (e) ->
    e.preventDefault()
    $tmp = $(this)
    $button = $tmp.find("a.open-category:first")
    if $button.hasClass('checked')
      $('#videos_' + $button.attr('data-id')).hide()
      $button.removeClass('checked')
      $button.addClass('unchecked')
    else
      $('.open-category').each () ->
        $item = $(this)
        $('#videos_' + $item.attr('data-id')).hide()
        $item.removeClass('checked')
        $item.addClass('unchecked')
      $('#videos_' + $button.attr('data-id')).show()
      $button.removeClass('unchecked')
      $button.addClass('checked')
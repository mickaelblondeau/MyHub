$ ->
  $(document).on "ajax:success", "#comment_block form[data-remote]", (e, data, status, xhr) ->
    $('#comment_block').replaceWith(data)
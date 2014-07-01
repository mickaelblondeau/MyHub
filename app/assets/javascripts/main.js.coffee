$ ->
  $(document).on "ajax:success", "#comment_block form[data-remote]", (e, data, status, xhr) ->
    $('#comment_block').replaceWith(data)
  $(document).on "ajax:success", "#like_block form[data-remote]", (e, data, status, xhr) ->
    $('#like_block').replaceWith(data)
  $(document).on "ajax:success", "#vote_block form[data-remote]", (e, data, status, xhr) ->
    $('#vote_block').replaceWith(data)
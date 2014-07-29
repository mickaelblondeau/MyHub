$ ->
  $(document).on "ajax:success", "#like_block form[data-remote]", (e, data, status, xhr) ->
    $('#like_block').replaceWith(data)

  $(document).on "ajax:success", "#vote_block form[data-remote]", (e, data, status, xhr) ->
    $('#vote_block').replaceWith(data)

  $(document).on "ajax:success", "#new_comment[data-remote]", (e, data, status, xhr) ->
    $('#comment_block').prepend(data)
    $('#comment_content').val('')
  $(document).on "ajax:success", "#comment_block .delete_comment form[data-remote]", (e, data, status, xhr) ->
    $('#comment-' + $(this).parent().attr('data-id')).remove()
  $(document).on "ajax:success", "#comment_block .comment_loader a[data-remote]", (e, data, status, xhr) ->
    $('#comment_block .comment_loader').remove()
    $('#comment_block').append(data)
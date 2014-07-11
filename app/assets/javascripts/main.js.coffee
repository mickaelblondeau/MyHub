$ ->
  $(document).on "ajax:success", "#comment_block form[data-remote]", (e, data, status, xhr) ->
    $('#comment_block').replaceWith(data)
  $(document).on "ajax:success", "#like_block form[data-remote]", (e, data, status, xhr) ->
    $('#like_block').replaceWith(data)
  $(document).on "ajax:success", "#vote_block form[data-remote]", (e, data, status, xhr) ->
    $('#vote_block').replaceWith(data)
  $(document).on "click", ".column-list-button", (e) ->
  	$('.column-list-button').hide()
  	$('.column-list').show()
  	$('.line-list-button').show()
  	$('.line-list').hide()
  $(document).on "click", ".line-list-button", (e) ->
  	$('.column-list-button').show()
  	$('.column-list').hide()
  	$('.line-list-button').hide()
  	$('.line-list').show()
  $(document).on "click", ".open-category", (e) ->
  	e.preventDefault()
  	$tmp = $(this)
  	$('.open-category').each () ->
  		$item = $(this)
  		$('#videos_' + $item.attr('data-id')).hide()
  		$item.removeClass('checked')
  		$item.addClass('unchecked')
  	if $tmp.hasClass('checked')
  		$('#videos_' + $tmp.attr('data-id')).hide()
  		$tmp.removeClass('checked')
  		$tmp.addClass('unchecked')
  	else if $tmp.hasClass('unchecked')
  		$('#videos_' + $tmp.attr('data-id')).show()
  		$tmp.removeClass('unchecked')
  		$tmp.addClass('checked')
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ($) ->
  counter = jQuery('.remaining-count')
  postForm = jQuery('#micropost_content')
  postFormSubmit = postForm.parents('form').find('input[type=submit]')

  postForm.on 'keyup', (e) =>
    counter.text(
      counter.text().replace /-*\d+/, ->
        remaining = 140 - postForm.val().length
        postFormSubmit.attr 'disabled', remaining < 0

        remaining
    )


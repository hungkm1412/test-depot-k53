jQuery(function($) {

  var handler = function() {
    var remain = 140 - $('#micropost_content').val().length
    
    $('.remaining-count').text(remain + ' characters remaining')
    $('#micropost_content').parents('form').find('input[type=submit]').attr('disabled', (remain < 0))
  }

  $('#micropost_content').on('keyup', handler)
                          .on('keydown', handler)
                          .on('change', handler)

})
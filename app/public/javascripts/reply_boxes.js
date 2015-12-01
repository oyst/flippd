  $(function() {
    $('.reply-box').hide();
    $('.reply-link').click(function() {
      $(this).parent().children('.reply-box').show();
    })
  });

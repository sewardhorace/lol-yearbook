$(function(){
  //infinite scroll
  var readyToPaginate = true;
  if ($('#infinite-scrolling').size() > 0){
    $(window).on('scroll', function(){
      if (readyToPaginate){
        var morePostsUrl = $('.pagination a.next_page').attr('href')
        if (morePostsUrl && $(window).scrollTop() > $(document).height() - $(window).height() - 20){
          $('.pagination').html("<span class='glyphicon glyphicon-refresh spinning'></span>");
          readyToPaginate = false;
          $.getScript(morePostsUrl, function(){
            readyToPaginate = true;
          });
        }
      }
    });
  }

  //submission
  $( "form.comment-form").on("submit", function(e) {
    e.preventDefault();
    var textarea = $('textarea[name=commentTextArea]')
    var text = $.trim(textarea.val());
    if (!text) {
      console.log("No content");
      return;
    }
    var comment = {
      'text': text,
      'id': textarea.data("id"),
      'type': textarea.data("type")
    };
    var data = {
      "comment": comment
    };
    $.ajax({
      type: "POST",
      url: $(this).data("url"),
      data: data,
      dataType: 'script',
      encode: true,
      success: function( result ) {
        console.log("SUCCESS");
        textarea.val("");
      },
      error: function( error ) {
        console.log("ERROR");
        var message = error.responseText;
        console.log(message);
      }
    });
  });

  //deletion
  $( ".comments-list").on("click", "input.delete-btn", function(e) {
    e.preventDefault();
    var result = window.confirm("Are you sure you want to delete this note?");
    if (!result){
      return;
    }
    var commentId = $(this).data("id");
    var comment = {
      'id': commentId
    };
    var data = {
      "comment": comment
    };
    $.ajax({
      type: "DELETE",
      url: $(this).data("url"),
      data: data,
      dataType: 'json',
      encode: true,
      success: function( result ) {
        console.log("SUCCESS");
        $("#comment-"+result.id).remove();
      },
      error: function( error ) {
        console.log("ERROR");
        var message = error.responseText;
        console.log(message);
      }
    });
  });
});

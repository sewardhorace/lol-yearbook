$(function(){
  //infinite scroll
  var readyToPaginate = true;
  if ($('#comments').size() > 0){
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
    var form = $(this);
    var textarea = form.children('textarea[name=commentTextArea]');
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
      url: form.data("url"),
      data: data,
      dataType: 'script',
      encode: true,
      success: function( result ) {
        console.log("SUCCESS");
        textarea.val("");
        if (textarea.data("type") === "Reply"){
          $(form).toggleClass("hidden");
        }
      },
      error: function( error ) {
        console.log("ERROR");
        var message = error.responseText;
        console.log(message);
      }
    });
  });

  //deletion
  $( "#comments").on("click", "input.delete-btn", function(e) {
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

  //replies
  $("#comments").on("click", "input.reply-btn", function(e) {
    var btn = $(this);
    var id = btn.data("id");
    $("#comment-" + id + " form").toggleClass("hidden");
  });

  $("#comments").on("click", "input.show-btn", function(e) {
    var btn = $(this);
    var id = btn.data("id");
    var all = $("#comment-"+id+" .all");
    if (all.children().length === 0){
      loadReplies(id);
    } else {
      btn.addClass("hidden");
      $("#comment-"+id+" .latest").addClass("hidden");
      all.removeClass("hidden");
      $("#comment-"+id+" .hide-btn").removeClass("hidden");
    }
  });

  $("#comments").on("click", "input.hide-btn", function(e) {
    var btn = $(this);
    var id = btn.data("id");
    btn.addClass("hidden");
    $("#comment-"+id+" .all").addClass("hidden");
    $("#comment-"+id+" .latest").removeClass("hidden");
    $("#comment-"+id+" .show-btn").removeClass("hidden");
  });

  var loadReplies = function(id){
    $("#comment-"+id+" .view-toggles").append("<span class='glyphicon glyphicon-refresh spinning'></span>");
    var comment = {
      'id': id,
    };
    var data = {
      "comment": comment
    };
    $.ajax({
      type: "GET",
      url: "/comment/" + id + "/replies",
      data: data,
      dataType: 'script',
      encode: true,
      success: function( result ) {
        console.log("SUCCESS");
        $("#comment-"+id+" .glyphicon-refresh").remove();
        $("#comment-"+id+" .show-btn").addClass("hidden");
        $("#comment-"+id+" .latest").addClass("hidden");
        $("#comment-"+id+" .all").removeClass("hidden");
        $("#comment-"+id+" .hide-btn").removeClass("hidden");
      },
      error: function( error ) {
        console.log("ERROR");
        var message = error.responseText;
        console.log(message);
        $("#comment-"+id+" .glyphicon-refresh").remove();
        $("#comment-"+id+" .view-toggles").append("<span>Error</span>");
      }
    });
  };
});

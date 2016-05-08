$(function(){
  $(".voting").on("click", "a", function(e) {
    var btn = $(this);

    var flag = btn.data("flag");
    if (flag === "upvote"){
      flag = true;
    } else if(flag === "downvote"){
      flag = false;
    } else {
      flag = null;
    }

    var comment = {
      'id': btn.data("id"),
      'vote_flag': flag
    };
    var data = {
      "comment": comment
    };
    $.ajax({
      type: "PUT",
      url: btn.data("url"),
      data: data,
      dataType: 'json',
      encode: true,
      success: function( result ) {
        console.log("SUCCESS");
        console.log(result);
        btn.siblings(".score").html("Changed");
      },
      error: function( error ) {
        console.log("ERROR");
        var message = error.responseText;
        console.log(message);
      }
    });
  });
});

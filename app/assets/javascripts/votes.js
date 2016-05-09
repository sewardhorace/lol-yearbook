$(function(){
  $( ".comments-list").on("click", ".vote-btn", function(e) {
    var btn = $(this);
    if (!btn.data("id")){
      return;
    }

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
        setButtonState(btn, result);
        setScore(btn.siblings(".score"));
      },
      error: function( error ) {
        console.log("ERROR");
        var message = error.responseText;
        console.log(message);
        btn.parent().prepend("<span>Error</span>");
      }
    });
  });

  var setButtonState = function(btn, vote){
    var otherBtn = btn.siblings(".vote-btn");
    btn.addClass("active");
    btn.data("flag", "unvote");
    otherBtn.removeClass("active");
    if (vote.flag === true){
      otherBtn.data("flag", "downvote");
    } else if (vote.flag === false){
      otherBtn.data("flag", "upvote");
    } else {
      var buttons = btn.add(otherBtn);
      buttons.removeClass("active");
      buttons.filter(".up").data("flag", "upvote");
      buttons.filter(".down").data("flag", "downvote");
    }
  };

  var setScore = function(scoreElement){
    var activeElement = scoreElement.siblings(".active");
    if (activeElement.hasClass("up")){
      scoreElement.html(scoreElement.data("score-upvoted"));
    } else if (activeElement.hasClass("down")){
      scoreElement.html(scoreElement.data("score-downvoted"));
    } else {
      scoreElement.html(scoreElement.data("score-unvoted"));
    }
  }
});

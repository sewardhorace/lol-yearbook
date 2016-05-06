$(function(){
  //filter champions by grade level
  $(".level-selectors").on("click", "button", function(e){
    var btn = $(this);
    $(".level-selectors button").removeClass("active");
    btn.addClass("active");
    var data = {
      "filter": btn.data("grade")
    };
    $.ajax({
      type: "GET",
      url: btn.data("url"),
      data: data,
      dataType: 'script',
      encode: true,
      success: function( result ) {
        console.log("SUCCESS");
      },
      error: function( error ) {
        console.log("ERROR");
        var message = error.responseText;
        console.log(message);
      }
    });
  });

  var updateBook = function(callbacks){
    var url = $("button.update").data("update-url");
    $.ajax({
      type: "POST",
      url: url,
      success: callbacks.success,
      error: callbacks.error
    });
  };

  var generateNewBook = function() {
    var btn = $("button.update");
    btn.hide();
    $(".level-selectors").after("<p class='text-center'><span class='glyphicon glyphicon-refresh spinning big'></span></p><p class='text-center status'>Generating...</p>");
    updateBook({
      success: function( result ) {
        console.log("Success!");
        location.reload();
      },
      error: function( error ) {
        $( "p.status ").html("An Error Occurred");
        console.log("ERROR");
        btn.html("Try Again");
        btn.show();
      }
    });
  };

  $( "button.update" ).on( "click", function(e) {
    $(this).addClass("disabled");
    $(this).html("<span class='glyphicon glyphicon-refresh spinning'></span>");
    updateBook({
      success: function( result ) {
        console.log("SUCCESS");
        console.log(result);
        location.reload();
      },
      error: function( error ) {
        console.log("ERROR");
        console.log(error);
        location.reload();
      }
    });
  });

  if ($('#champions').size() > 0){
    if ($('#champions').data("need-update")) {
      generateNewBook();
    }
  }
});

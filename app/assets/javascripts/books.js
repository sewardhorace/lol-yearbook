$(function(){
  //filter champions by grade level
  $(".level-selectors").on("click", "input", function(e){
    var box = $(this);
    var level = box.val();
    toggleChampionVisibility(level);
    syncCheckboxes(box);
  });

  var toggleChampionVisibility = function(level){
    var section = $("#_" + level);
    if (section.hasClass("hidden")){
      section.removeClass("hidden");
    } else {
      section.addClass("hidden");
    }
  };

  var syncCheckboxes = function(checkbox){
    var boxes = $("input._" + checkbox.val());
    if (checkbox.prop("checked")){
      boxes.prop("checked", true);
    } else {
      boxes.prop("checked", false);
    }
  };

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
    if ($(this).hasClass("disabled")){
      return;
    }
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

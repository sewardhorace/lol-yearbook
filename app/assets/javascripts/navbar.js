$(function(){
  $(".region").on("click", function(e){
    var regionName = $(this).html();
    var regionCode = $(this).data("region");
    $('input[name="region-button"]').val(regionName);
    $('input[name="region"]').val(regionCode);
  });
});

var lastHidden;
var hot = $(".hot");

$(document).ready(function(){
  $('#undo-hide').hide();
  showHot();
  $('.hide-listing').click(function(){
    showUndoHideButton();
  });
});

function showHot() {
  hot = $(".hot")
  if(hot.length > 0) {
    $('#whats-hot').removeClass('hide');
    $.each(hot, function(k, v){
      $('#whats-hot').append($(v));
    });
  }
}

function showUndoHideButton() {
  $('#undo-hide').show();
  setTimeout(function() {
   $('#undo-hide').fadeOut();
 }, 3000 );
}

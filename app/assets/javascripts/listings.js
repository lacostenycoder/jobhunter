var lastHidden;
var ready;
// use ready to wrap document ready into variable called on page:change 
ready = function(){
  $('#undo-hide').hide();
  $('.hide-listing').click(function(){
    showUndoHideButton();
  });
  // close flash notice on clicks
  $('#flash-notice-container').on('click','*', function(){
    var flash = (function(){
      return $('#flash-notice-container');
    });
    flash().text('');
  });
  showHot();
}

$(document).ready(ready);
$(document).on('page:change', ready);

function showHot() {
  var hot = function(){
    return $(".hot");
  }
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

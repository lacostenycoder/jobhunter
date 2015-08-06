var lastHidden;
var hot = $(".hot");

$(document).ready(function(){
  showHot();
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


// hot = $('.hot')
//
// showHot = ->
//   hot = $('.hot')
//   if hot.length > 0
//     $('#whats-hot').removeClass 'hide'
//     $.each hot, (k, v) ->
//       $('#whats-hot').append $(v)
//       return
//   return
//
// $(document).ready ->
//   showHot()
//   return

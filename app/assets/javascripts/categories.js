$(document).ready(function() {

  $('.collapse').each(function(i, obj) {
    $(this).on('hidden.bs.collapse', function() {
        localStorage.setItem( $(this).attr("id"), "hidden" );
    });
    $(this).on('shown.bs.collapse', function() {
        localStorage.removeItem( $(this).attr("id") );
    });
  });

  for (var i in localStorage) {
    var val = localStorage[i];
    if (val == "hidden") {
      $("#" + i).collapse('hide');
    }
  }
});
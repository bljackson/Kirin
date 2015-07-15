 jQuery(document).ready(function(){  
 
  //target the class 'accordion-body' 
  jQuery('.panel-body').on('shown', function(e){
 
   //save the uncollapsed/shown item ID to your cookie:
   jQuery.cookie('cookie_collapse', jQuery(e.target).attr('id'));
  });
 
  var lastCollapse = jQuery.cookie('cookie_collapse');
 
    //if the cookie exists:-
    //activate uncollapsed item by adding the class 'in' to the saved ID
     if (lastCollapse) {
      var lastCollapse = '#' + lastCollapse
      jQuery(lastCollapse).addClass('in');
     }
 } );
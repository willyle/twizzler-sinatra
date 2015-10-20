
// When the page loads, look for a flash 
// messaging modal and display it if it's available
$(window).load(function(){
	$('.flashModal').modal('show');
});


// First check to see if a there is an element
// on the page with a class of ".character-count"
// If so, Lets use the limiter plugin to keep
// track of character count so users cannot input 
// more than 150 characters
if ( $( ".character-count" ).length ) {
	var elem = $(".character-count");
	$(".twizzle-textarea").limiter(150, elem);
}

// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
	//$('.quantity').val('Put number');
	$('.add-to-cart').click(function(){
		//$(this).parent().css('background-color', 'green');
		
		var value = $(this).siblings('.quantity').val();
		var value_int = parseInt(value); //Convert value into an integer
		
		var product_id = $(this).siblings('.product-id').val();
		
		if(value_int > 0){
			//alert('Thank you!');
			
			//Make an AJAX call
			$.post('/store/add_cart', {
				quantity : value_int,
				product_id : product_id
			}); //Make a post request; first param is a URI, second param is a hash with quantity and value
		}
		else{
			alert('Please type in a number! ' + value + ' is not a valid quantity number!');
		}
		
	});
});

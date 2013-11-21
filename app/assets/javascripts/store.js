// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
	//$('.quantity').val('Put number');
	$('.add-to-cart').click(function(){
		//$(this).parent().css('background-color', 'green');
		
		var value = $(this).siblings('.quantity').val();
		var value_int = parseInt(value); //Convert value into an integer
		
		var product_id = $(this).siblings('.product-id').val();
		var product_name = $(this).data('product-name');
		var price = $(this).data('price');
		
		if(value_int > 0){
			//alert('Thank you!');
			
			//Make an AJAX call
			$.post('/store/add_cart', {
				quantity : value_int,
				product_id : product_id,
				product_name : product_name,
				price : price
			}); //Make a post request; first param is a URI, second param is a hash with quantity and value
		}
		else{
			alert('Please type in a number! ' + value + ' is not a valid quantity number!');
		}
		
	});
	
	$('#toggle_cart_button').click(function(){
		//$('#cart_detail_panel').toggle('slow'); //OR
		
		//var display = $('#cart_detail_panel').css('display');
		//if (display == 'none'){
			//$('#cart_detail_panel').css('display', 'block');
			//} else {
				//$('#cart_detail_panel').css('display', 'none');
			//}
			
			//CAN ALSO DO
			
		var display = $('#cart_detail_panel').css('display');
		if (display == 'none'){
			$('#cart_detail_panel').slideDown();
			} else {
				$('#cart_detail_panel').slideUp();
			}
			
	});
	
});

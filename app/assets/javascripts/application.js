// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require_tree .

function show_signup()
{
 $("#login_div").fadeOut('fast', function() {
  $("#register_div").fadeIn();
 });
}
function show_login()
{
 $("#register_div").fadeOut('fast', function() {
  $("#login_div").fadeIn();
 });
}

$(document).ready(function(){

	$('.like').click(function(event){
	 	var button = $(this).children('.vote-btn');
	 	button.addClass("hide-icon");
	 	
	 });


	$('.add').click(function(event){
		var span = $(this).children('.span');
		var icon = $(this).children('.icon')
		span.addClass("hide-icon");
		icon.removeClass("hide-icon");
	});

	$('.vote-btn').click(function(event){
		event.preventDefault();
		var recipeId = {
			'id': $(this).attr('value')
		}

		$.ajax({
			method: 'POST',
			url: `/recipe/${recipeId['id']}/votes`,
			data: recipeId,
			dataType: 'JSON',
			success: function(data){
				if(data.message == 'Successful'){
					console.log(data['new_count']);
					$(`.vote-count-${recipeId['id']}`).html(`Likes: ${data.new_count}`)
				}else if (data.message == 'Failed'){
				}
			}, error: function(error) {
				console.log(error);
			}
		});
	
	});
});

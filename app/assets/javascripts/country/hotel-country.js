$(document).ready(function(){
	var $dateContainer = $('.hotel-search--date');
	$('.hotel-roundtour-date--open').click(function(){
		if($dateContainer.is(':hidden')){
			$dateContainer.slideDown(300);
			$('body,html').animate({
				scrollTop : $dateContainer.offset().top - 53
			},300);
		}
		return false;
	});
	$('.hotel-selectdate--save').click(function(){
		// dateSave();
		$dateContainer.slideUp(150);
		$('body,html').animate({
			scrollTop : $('.hotel-search--container').offset().top - 53
		},300);
		return false;
	});
	setTimeout(hidePreload,1000);
	function hidePreload(){
		$('.tour-search-preload').fadeOut(500);
	}
});
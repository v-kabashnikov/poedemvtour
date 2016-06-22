$(document).ready(function(){
	$('.tour-page-slider').slick({
		slidesToShow : 4,
		slidesToScroll : 4,
		vertical : true,
		verticalSwiping : true,
		arrows : true,
		responsive : [
			{
				breakpoint : 991,
				settings : {
					arrows : false
				}
			}
		]
	});
	$('.tour-page-includes .tab-header a').click(function(){
		var $item = $(this).parent();
		var index = $item.index();
		var $tab = $('.tour-page-includes .tab-item');
		if(!$item.hasClass('.tab-header--active')){
			$tab.filter(':visible').stop(true).fadeOut(150);
			$tab.eq(index).stop(true).delay(200).fadeIn(200);
			$('.tour-page-includes .tab-header li').filter('.tab-header--active').removeClass('tab-header--active');
			$item.addClass('tab-header--active');
		}
		return false
	});
	$('.tour-page-includesxs--header').click(function(){
		$(this).parent().toggleClass('tour-page-includesxs--item_active');
		return false;
	});
	$('.form-tourpage--header-toggle').click(function(){
		$(this).parent().toggleClass('form-tourpage--header_hide');
		$(this).closest('fieldset').find('.inputs-container').slideToggle(200);
		return false;
	});
	pricePosition();
	$(window).on('scroll',function(){
		// 221
		pricePosition();
	});
	function pricePosition(){
		if($('div').is('.tour-page_2-price')){
			var scroll = $(document).scrollTop();
			if(scroll > 100){
				var top = scroll-100;a
				var marginTop = parseFloat($('footer').offset().top) - parseFloat($('.tour-page_2-price').innerHeight()) - 230;
				console.log('top='+ top);
				console.log('marginTop=' + marginTop);
				if(top < marginTop){
					$('.tour-page_2-price').css({top:top});
				}
			}else{
				$('.tour-page_2-price').css({top:0});
			}
		}
	}
});
(function(){
  $('.country-search--date').slideDown(0);
  $('.country-photo-slider').slick({
    slidesToShow: 4,
    slidesToScroll: 4,
    arrows: true,

    prevArrow: '<button type="button" class="slick-arrow slick-prev"><span class="icons-arrow-left_border_yellow"></span></button>',
    nextArrow: '<button type="button" class="slick-arrow slick-next"><span class="icons-arrow-right_border_yellow"></span></button>',
    responsive: [
      {
        breakpoint: 991,
        settings: {
          arrows: false
        }
      }
    ]
  });
  $('.country-chart-list a').on('click',function(){
    if(!$(this).hasClass('country-chart-list_active')){
      $(this).closest('.country-chart-list').find('.country-chart-list_active').removeClass('country-chart-list_active');
      $(this).addClass('country-chart-list_active');
      console.log('change month!');
      var price = '7 849 400';
      $('.country-resorts-item-price').filter(':not(.country-resorts-item-price_learn)').each(function(){
        price = Math.round(Math.random() + 5) + ' 8' + Math.round(Math.random() + 5) + '9 ' + Math.round(Math.random() + 5) + '00'
        $(this).find('span').text(price);
      });
    }
    return false;
  });
  //var resortsCounter = 0;
  //$('.country-resorts-showmore').on('click',function(){
  //  resortsCounter++;
  //  var item = $('.country-resorts-item_popular').last().clone();
  //  $('.country-resorts_popular .country-resorts-list').append(item);
  //  console.log('load resorts!');
 //   if(resortsCounter >= 2){
 //     $(this).parent().slideUp(200,function(){
  //      $(this).remove();
 //     });
 //   }
 //   return false;
 // });
  $('.country-info-select .form-control').change(function(){
    console.log($(this).attr('name') + ' change');
  });
  $('.country-video-link').on('click', function(){
    $.fancybox({
      'padding'   : 0,
      'transitionIn'  : 'none',
      'transitionOut' : 'none',
      'href'      : this.href.replace(new RegExp("watch\\?v=", "i"), 'v/'),
      'type'      : 'swf',
      'swf'     : {
           'wmode'    : 'transparent',
        'allowfullscreen' : 'true'
      }
    });
    return false;
  });
  $(".phone-mask").mask("+7 (999) 999 99 99");
  var isSubmit = false;
  $('.country-notfound-form').on('submit',function(){
    var $form = $(this);
    var $call = $form.next();
    if(!isSubmit){
      showSucces();
    }else{
      resetForm();
    }
    function showSucces(){
      $form.addClass('country-notfound-form_submit');
      $form.find('.form-control').fadeOut(100);
      $form.find('.form-send').find('.text1').fadeOut(100,function(){
        $form.find('.form-send').find('.text2').fadeIn(200);
      });
      $call
        .addClass('success')
        .find('.text1').fadeOut(200,function(){
          $call.find('.text2').fadeIn(300);
        });
      isSubmit = true;
    }
    function resetForm(){
      $form.removeClass('country-notfound-form_submit');
      $form.find('.form-control').val('').delay(300).fadeIn(100);
      $form.find('.form-send').find('.text2').delay(300).fadeOut(100,function(){
        $form.find('.form-send').find('.text1').fadeIn(200);
      });
      $call
        .removeClass('success')
        .find('.text2').fadeOut(200,function(){
          $call.find('.text1').fadeIn(300);
        });
      isSubmit = false;
    }
    console.log(isSubmit);
    return false;
  });
  var chartSlider = {
    $slider: $('.country-chart-slider'),
    $list: $('.country-chart-list'),
    $item: $('.country-chart-list .col-xs-1'),
    $prev: $('.country-chart-prev'),
    $next: $('.country-chart-next'),
    current: 1,
    nav: function(type){
      var current = chartSlider.current;
      var currentOld,currentNew;
      var removeClass,addClass;
      var name = 'country-chart-list_slide';
      if(type == 'prev'){
        if(current > 1){
          currentOld = current;
          current--;
          currentNew = current;
        }else{
          currentOld = 1;
          current = 3;
          currentNew = current;
        }
      }else{
        if(current < 3){
          currentOld = current;
          current++;
          currentNew = current;
        }else{
          currentOld = current;
          current = 1;
          currentNew = current;
        }
      }
      removeClass = name + currentOld;
      addClass = name + currentNew;
      chartSlider.$list.removeClass(removeClass);
      chartSlider.$list.addClass(addClass);
      chartSlider.current = currentNew;
    }
  }
  chartSlider.$prev.on('click', function(){
    chartSlider.nav('prev');
    return false;
  });
  chartSlider.$next.on('click', function(){
    chartSlider.nav('next');
    return false;
  });
  // google.maps.event.addDomListener(window, 'load', init);
  var isInit = false;
  $('.country-info-hotels a').on('click',function(){
    if(!isInit){
      init();
      isInit = true;
    }
  })
})($);
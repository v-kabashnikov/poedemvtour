/***********************************
 * Created by Devorans.com
 * Author: Admin
 * File:
 * Project: tour
 * Date: 14.10.2015
 * Feedback: support@devorans.com
 ************************************/


//*  SUB HEADER FILTER  */
(function(){
  $('[data-click="showfilter"]').click(function(){
    $('#sub-header-filter').slideDown();
    $('#nav-toggle').addClass('activeFilter');
    return false;
  });

  if(window.location.hash == "#showfilter"){
    $('[data-click="showfilter"]')[0].click();
  }
})($);

//*  NAV TOGGLE ICON */
(function(){
  $('#nav-toggle').click(function(){
    if($(this).hasClass('activeFilter')){
      $('#sub-header-filter').slideUp();
      $('#nav-toggle').removeClass('activeFilter');
      return false;
    }
    else {
      if($($(this).data('target')).hasClass('canvas-slid')){
        $(this).removeClass('active');
      }
      else{
        $(this).addClass('active');
      }
    }
  });
  $(document).on('click','.canvas-slid',function(e){
    if($(e.target).closest('#site-menu').length < 1){
      $('#nav-toggle').removeClass('active');
    }
  })
})($);

//*  SCROLL TO TOP */
(function(){
  $('#stt').click(function () {
    $('body,html').animate({scrollTop: 0}, 400);
    return false;
  });
})($);

//*  FIXED MENU  */
(function(){
  var myNavBar = {

    flagAdd: true,

    elements: [],

    init: function (elements) {
      this.elements = elements;
    },

    add : function() {
      if(this.flagAdd) {
        for(var i=0; i < this.elements.length; i++) {
          document.getElementById(this.elements[i]).className += " fixed-theme";
        }
        this.flagAdd = false;
      }
    },

    remove: function() {
      for(var i=0; i < this.elements.length; i++) {
        document.getElementById(this.elements[i]).className =
            document.getElementById(this.elements[i]).className.replace( /(?:^|\s)fixed-theme(?!\S)/g , '' );
      }
      this.flagAdd = true;
    }

  };

  /**
   * Init the object. Pass the object the array of elements
   * that we want to change when the scroll goes down
   */
  myNavBar.init(  [
    "all-header",
    "login-link",
    "nav-toggle"
  ]);

  /**
   * Function that manage the direction
   * of the scroll
   */
  function offSetManager(){

    var yOffset = 0;
    var currYOffSet = window.pageYOffset;

    if(yOffset < currYOffSet) {
      myNavBar.add();
    }
    else if(currYOffSet == yOffset){
      myNavBar.remove();
    }

  }

  /**
   * bind to the document scroll detection
   */
  window.onscroll = function() {offSetManager();};

  /**
   * We have to do a first detectation of offset because the page
   * could be load with scroll down set.
   */
  offSetManager();
})();

//*  MAIN PAGE ACCORDEON  */
(function(){
  $('.main-page').on('click','.item .title-price', function(){
    if(!$(this).closest('.item').hasClass('opened')){
      $(this).closest('.main-page').find('.item').removeClass('opened');
      $(this).closest('.item').addClass('opened');
    }
    else{
      $(this).closest('.item').removeClass('opened');
    }

  })
})($);

//*  HEADER SLIDER  */
(function(){

  $(".carousel")
      .swiperight(function() {$(this).carousel('prev');})
      .swipeleft(function() {$(this).carousel('next');});

  carouselContainer = $('#header-slider');

  function MYtoggleA(e){
    //console.log(e);
    $oldSlide = carouselContainer.find('.item.active');
    $newSlide = $(e.relatedTarget);

    $m_direction = 'margin-'+e.direction;
    $m_antidirection = e.direction=='left'?'margin-right':'margin-left';

    oNewStyle = {};
    oNewStyle[$m_direction] = '500px';
    oNewStyle[$m_antidirection] = '-500px';
    oNewStyle.opacity = 'hide';

    resetStyle = {};
    resetStyle[$m_direction] = '0px';
    resetStyle[$m_antidirection] = '0px';

    oAnimateOld = {};
    oAnimateOld[$m_direction] = '-500px';
    oAnimateOld[$m_antidirection] = '500px';
    oAnimateOld.opacity = 'hide';

    oAnimateNew = {};
    oAnimateNew[$m_direction] = '0px';
    oAnimateNew[$m_antidirection] = '0px';
    oAnimateNew.opacity = 'show';

    $oldSlide.find('h3').animate(oAnimateOld,1000,'easeInOutQuint');
    $oldSlide.find('em').delay( 200 ).animate(oAnimateOld,1000,'easeInOutQuint');
    $oldSlide.find('.btnset').delay( 400 ).animate(oAnimateOld,1000,'easeInOutQuint');

    $newSlide.find('h3').css(oNewStyle)
        .delay( 500 ).animate(oAnimateNew,1000,'easeInOutQuint');
    $newSlide.find('em').css(oNewStyle)
        .delay( 700 ).animate(oAnimateNew,1000,'easeInOutQuint');
    $newSlide.find('.btnset').css(oNewStyle)
        .delay( 900 ).animate(oAnimateNew,1000,'easeInOutQuint',function(){
                                carouselContainer.find('.item').find('h3,em,.btnset').css(resetStyle);
                              });


  }
  function MYtoggleB(e){
  }

  carouselContainer
      .on('slide.bs.carousel', MYtoggleA)
      .on('slid.bs.carousel', MYtoggleB);

  // handles the carousel thumbnails
  $('[id^=carousel-selector-]').click( function(){
    var id_selector = $(this).attr("id");
    var id = id_selector.substr(id_selector.length -1);
    id = parseInt(id);
    carouselContainer.carousel(id);
    $('[id^=carousel-selector-]').removeClass('selected');
    $(this).addClass('selected');
  });

  // when the carousel slides, auto update
  carouselContainer.on('slid.bs.carousel', function (e) {
    var id = parseInt($('.carousel-indicators li.active').data('slideTo'));
    console.log(id);
    $('[id^=carousel-selector-]').removeClass('selected');
    $('[id=carousel-selector-'+id+']').addClass('selected');
  });

})($);

//*  SELECTISE  */
(function(){
  $('.selectize').selectize({allowEmptyOption:true});
  $('.selectize-text').selectize();
})($);

//*  CALENDAR INPUT  */
(function(){
  $('input[data-type="datepicker"], .input-group.date').datetimepicker({
    locale: 'ru',
    format: "DD.MM.YYYY",
    sideBySide: true
  });
})($);

//*  CIRCLE BLOCKS  */
(function(){
  $circles = $('#circle-blocks');
  $circles.on('click','.block:not(.active)',function(){
    $circles.find('.active').removeClass('active');
    $(this).addClass('active');
    $('[data-target='+this.id+']').addClass('active');
  });

  $circles.on('click','.controls span:not(.active)',function(){
    $circles.find('.active').removeClass('active');
    $('#'+$(this).data('target')).addClass('active');
    $(this).addClass('active');
  });
})($);

//*  FAQ  */
(function(){
  $faq = $('#faq');
  $faq.find('.question').click(function () {
    $item = $(this).closest('.item');
    if($item.hasClass('active')){
      $item.find('.answer').slideUp(300,function(){
        $item.removeClass('active');
      });
    }
    else{
      $faq.find('.active .answer').slideUp(
          300,
          function(){
            $(this).closest('.item').removeClass('active');
          });
      $item.addClass('active').find('.answer').slideDown(300);
    }
  });

  $faq.find('.answer').css('display','none');

})($);

//*  MAPS BLOCK SCROLL  */
(function(){
  $map_wrap = $('.frame-map');

  $map_wrap.on('click', function(){
    $(this).find('iframe').css("pointer-events", "auto");
  });
  $map_wrap.on('mouseleave',function(){
    $(this).find('iframe').css("pointer-events", "none");
  });

  $map_wrap.css("pointer-events", "none");
})($);

//*  PLUSO  */
(function(){

})($);

//*  COUNT INPUT  */
(function(){
  $('.count-input')
      .on('click','.plus',function(){
    $input = $(this).parent().find('input');
    $input.val(parseInt($input.val())+1);
  })
      .on('click','.minus',function(){
    $input = $(this).parent().find('input');
    $input.val(parseInt($input.val())-1);
  });
})($);

//*  X-INPUT  */
(/* x-input-plus-minus */ function(){
  $xPM = $('.x-input-plus-minus');
  $xPM.on('click', '.x-plus', function () {
    $input = $(this).parent().find('input');
    var newVal = parseInt($input.val()) + 1;
    var maxVal = parseInt($input.attr('max'));
    newVal = (maxVal > newVal) ? newVal : maxVal;
    $input.val(newVal);
    $input.blur();
  });
  $xPM.on('click', '.x-minus', function () {
    $input = $(this).parent().find('input');
    var newVal = parseInt($input.val()) - 1;
    var minVal = parseInt($input.attr('min'));
    newVal = (minVal < newVal) ? newVal : minVal;
    $input.val(newVal);
    $input.blur();
  });
})($);
(/* x-input-dd */ function(){
  $xDD = $('.x-input-dd');
  $xDD.each(function(){
    this.setDef = function(){
      var $this = $(this);
      var $input = $this.find('input');
      if($input.attr('placeholder')){
        $this.children('sub').html('<i>'+$input.attr('placeholder')+'</i>');
      }
      else{
        var $defItem = $this.find('span i:first');
        var defVal = $defItem.data('value');
        var defTxt = $defItem.html();
        $input.val(defVal);
        $this.children('sub').html(defTxt);
      }
    };
    var $this = $(this);
    $this.addClass('closed');
    var curVal = $this.find('input').val();
    if(curVal){
      var $selected = $this.find('span i[data-value='+curVal+']');
      var valName = $selected.html();
      if($selected && valName){
        $this.children('sub').html(valName);
        $selected.addClass('selected');
      }
      else this.setDef();
    }
    else this.setDef();
  });

  $xDD.on('click','sub',function(){
    var $this = $(this).closest('.x-input-dd');
    if($this.hasClass('closed')){
      var $allOpened = $xDD.filter('.opened');
      $allOpened.find('span').stop().slideUp(300);
      $allOpened.removeClass('opened').addClass('closed');
      $this.find('span').stop().slideDown(300);
      $this.removeClass('closed').addClass('opened');
    }
    else{
      $this.find('span').stop().slideUp(300);
      $this.removeClass('opened').addClass('closed');
    }
  });
  $xDD.on('click','span i',function(){
    var $this = $(this).closest('.x-input-dd');
    var newVal = $(this).data('value');
    var newTxt = $(this).html();
    $this.find('span i.selected').removeClass('selected');
    $(this).addClass('selected');
    $this.children('sub').html(newTxt);
    $this.children('input').attr('value',newVal);
    $this.find('span').stop().slideUp(300);
    $this.removeClass('opened').addClass('closed');

  });

  $(document).on('click',function(e){
    if(!$(e.target).closest('.x-input-dd').length){
      var $allOpened = $xDD.filter('.opened');
      $allOpened.find('span').stop().slideUp(300);
      $allOpened.removeClass('opened').addClass('closed');
    }
  });
})($);
(/* x-input-chk-group */ function(){
  $xCBG = $('.x-input-chk-group');
  $xCBG.each(function(){$(this).addClass('closed');});
  $xCBG.on('click','sub',function(){
    var $this = $(this).closest('.x-input-chk-group');
    if($this.hasClass('closed')){
      var $allOpened = $xCBG.filter('.opened');
      $allOpened.find('.x-group').stop().slideUp(300);
      $allOpened.removeClass('opened').addClass('closed');
      $this.find('.x-group').slideDown(300);
      $this.removeClass('closed').addClass('opened');
    }
    else{
      $this.find('.x-group').slideUp(300);
      $this.removeClass('opened').addClass('closed');
    }
  });
  $(document).on('click',function(e){
    if(!$(e.target).closest('.x-input-chk-group').length){
      var $allOpened = $xCBG.filter('.opened');
      $allOpened.find('.x-group').slideUp(300);
      $allOpened.removeClass('opened').addClass('closed');
    }
  });
})($);

//*  Ð—ÐÐ“Ð›Ð£Ð¨ÐšÐ Ð¡Ð¡Ð«Ð›ÐžÐš # */
(function(){
  $('a').click(function(){
    if($(this).attr('href')=='#'){
      return false;
    }
  });
})($);

(function(){
  $('.hotel-slider').slick({
    dots: false,
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
     responsive: [
      {
        breakpoint: 991,
        settings: {
          arrows: false
        }
      },
      {
        breakpoint: 768,
        settings: {
          arrows: false,
          slidesToShow: 1,
          slidesToScroll: 1
        }
      }
    ]
  });
  hotelArrows();
  $(window).resize(hotelArrows);
  function hotelArrows(){
    var dots = 0;
    $('.hotel-slider .slick-dots').find('li').each(function(){
      dots += $(this).width()+8;
    });
    $('.hotel-slider .slick-prev').css({
      'margin-right' : dots/2+20
    });
    $('.hotel-slider .slick-next').css({
      'margin-left' : dots/2+20
    });
  }

})($);
(function(){
  $(".fancybox").fancybox({
    fitToView: false,
    maxWidth: "90%"
  });
})($);
(function(){
  $('.tab-xs-header').click(function(){
    $(this).toggleClass('tab-xs-header_active');
    $(this).find('.fa').toggleClass('fa-angle-down').toggleClass('fa-angle-up')
    $(this).parent().next().slideToggle(400).toggleClass('in active');
    return false;

  });
})($);
(function(){
  $('.hotel-options-xs-select').click(function(){
    $(this).find('.fa').toggleClass('fa-caret-down').toggleClass('fa-caret-up');
    $(this).next().slideToggle(200);
    return false;
  });
  $('.hotel-options-xs-select--submenu a').click(function(){
    if($(window).width()<=767){
      var menu = $(this).closest('.hotel-options-xs-select--submenu');
      menu.slideUp(200);
      menu.prev().find('.text').text($(this).text());
    }
  });
  $(window).resize(function(){
    var menu = $('.hotel-options-xs-select--submenu');
    menu.slideDown(0);
  });
})($);
(function(){
  $('.hotel-addcomment-addphoto').click(function(){
    var photo, photoHeader, photoFooter, photoBody;
    function photoIndex(){
      return $('.hotel-addcomment-item').last().index() + 1
    }
    photoHeader = '<div class="hotel-addcomment-item"><div class="hotel-addcomment-photo"><a href="#" class="hotel-addcomment-photo--remove"><i class="fa fa-times" aria-hidden="true"></i></a><span class="hotel-addcomment-photo--text">Загрузить<br>фото</span>';
    photoFooter = '</div></div>';
    for(var i = 0;i<3;i++){
      photoBody = '<input type="file" class="hotel-addcomment-photo--input" name="review[img' + photoIndex() + ']" accept="image/*">';
      photo = photoHeader + photoBody + photoFooter;
      $('.hotel-addcomment-photos').append(photo);
    }
    return false;
  });
  $(document).on('change', '.hotel-addcomment-photo--input', function(){
     commentPhotoLoad($(this));
   });
   $('.hotel-addcomment-photo--remove').on('click', function(){
     commentPhotoRemove($(this));
     return false;
   });
   $(document).on('click', '.hotel-addcomment-photo--remove', function(){
     commentPhotoRemove($(this));
     return false;
   });
   function commentPhotoLoad(input){
     var $photo = input.closest('.hotel-addcomment-photo');
     readURL(input,$photo);
   }
   function commentPhotoRemove(link){
     var $photo = link.closest('.hotel-addcomment-photo');
     $photo.find('.hotel-addcomment-photo--remove').fadeOut(50);
     $photo.find('.hotel-addcomment-photo--text').fadeIn(100);
     $photo.find('input').val('');
     $photo.find('img').remove();
   }
   function readURL(input,$photo) {
     var input = input[0];
     var $photo = $photo;
     if (input.files && input.files[0]) {
       var reader = new FileReader();
 
       reader.onload = function (e) {
           $photo.append('<img src="' + e.target.result + '">');
           $photo.find('.hotel-addcomment-photo--remove').fadeIn(100);
           $photo.find('.hotel-addcomment-photo--text').fadeOut(50);
       }
 
       reader.readAsDataURL(input.files[0]);
     }
   }
})($);
(function(){

  /*$(document).ready(function(){
    mainSlider('.main-slider');
    function mainSlider(container){
      var container = $(container);
      var slide = container.find('.slide');
      alert(slide.html());
      init();
      function init(){
        showSlide(0);
      }
      function showSlide(index){
        var index = index;
        var slide = slide.eq(index);
        slide.show(300);
      }
    }
  });  */
  var mainSlider = $('.main-slider');
  mainSlider.on('init', function(event, slick){
    //$('.slick-active .slide-text').removeClass('hidden');
    //$('.slick-active .slide-text').addClass('animated fadeInDown');
  });
  mainSlider.slick({
    infinite: true,
    slidesToShow: 1,
    slidesToScroll: 1,
    arrows: false,
    dots: true,
    autoplay: true,
    autoplaySpeed: 5000,
    fade: true,
    speed: 1000,
    cssEase: 'ease-out',
    responsive: [
      {
        breakpoint: 767,
        settings: {
          dots:false
        }
      }
    ]
  })
  .on('afterChange', function(event, slick, currentSlide){
    //$('.slick-active .slide-text').removeClass('hidden');
    //$('.slick-active .slide-text').addClass('animated fadeInDown');
  })
  .on('beforeChange', function(event, slick, currentSlide){
      //$('.slick-active .slide-text').removeClass('animated fadeInDown');
      //$('.slick-active .slide-text').addClass('hidden');
  });

})($);
(function(){
  $('.main-offer-slider').slick({
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
    arrows: true,
    responsive: [
      {
       breakpoint: 1240,
        settings: {
          arrows: false
        }
      },
      {
        breakpoint: 991,
        settings: {
          slidesToShow: 2,
          slidesToScroll: 2,
          arrows: false
        }
      }
    ]
  });
})($);
(function(){
  $(document).ready(function(){
    $(".roundtour-price").ionRangeSlider({
      min: 0,
      max: 10000000,
      from: 0,
      to: 9000000,
      type: 'double',
      step: 50000,
      postfix: '<i class="fa fa-rub"></i>',
    });
  });
})($);
(function(){
  $('.scrollbar-inner').scrollbar();
  $('.roundtour-city--select').click(function(){
    $('.roundtour-city--submenu').show(0);
    $('.roundtour-city--search').val($(this).text());
    return false;
  });
  $('.roundtour-city--close').click(function(){
    $('.roundtour-city--submenu').hide(0);
    return false;
  });
  $('.roundtour-city--list li').click(function(){
    $('.roundtour-city--search').val($(this).text());
    $('#city-id').val($(this).attr('data-city-id'));
    $('.roundtour-city--select').text($(this).text());
    $('.roundtour-city--submenu').hide(0);
    return false;
  });
  $('.roundtour-city--search').keyup(function(){
    var search = $(this).val().toLowerCase();
    $('.roundtour-city--list li').each(function(){
      var text = $(this).text().toLowerCase();
      if(text.indexOf(search) + 1){
        $(this).css({'display': 'block'});
      }else{
        $(this).css({'display': 'none'});
      }
    });
  });
  $('.roundtour-place').click(function(){
    $('.roundtour-place--submenu').show(0);
      $('.roundtour-place--search').val('').focus();
     $(document).mouseup(function (e) {
        var container = $(".roundtour-place--submenu");
        if (container.has(e.target).length === 0){
            hidePlaceSubmenu('');
        }
      });
    return false;
  });

   $('.roundtour-place--list').on('click', 'li', function(o){
    console.log(o);
    var $thisItem = $(o.target);
    if(!$thisItem.is('li')){
      $thisItem = $thisItem.closest('li');
    }
    var text = $thisItem.find('.roundtour-place--curort').text();
    hidePlaceSubmenu(text);
    $('.roundtour-place--search').val(text);
    $('.roundtour-place').find('.text').text(text);
    $('.roundtour-place--submenu').hide(0);
    $('#place_id').val($thisItem.attr('data-id'))
    $('#place_type').val($thisItem.attr('data-type'))
    // $(this).find('li').css({'display': 'none'});
    return false;
  });
   function hidePlaceSubmenu(text){
    if($('.roundtour-place--submenu').is(':visible')){
     if(text!=''){
       $('.roundtour-place').find('.text').text(text);
     }else{
        $('.roundtour-place').find('.text').text('Где хотите отдохнуть?');
     }
     $('.roundtour-place--search').val(text);
     $('.roundtour-place--submenu').hide(0);
 }
  }
  $('.roundtour-place--search').keyup(function(){
    var search = $(this).val().toLowerCase();
    $('.roundtour-place--list').find('li').each(function(i, el){
      console.log(el);
      var text = $(el).find('.roundtour-place--curort').text().toLowerCase();
      if(text.indexOf(search) + 1){
        $(el).css({'display': 'block'});
      }else{
        $(el).css({'display': 'none'});
      }
    });
  });
  $(document).on(
    {
      'click': function(){
        $(this).parent().hide(200,function(){
          $(this).remove();
          visible('adults','.roundtour-people--addadults');
          visible('childrens','.roundtour-people--addchildrens');
        })
        return false;
      },
    },
    '.roundtour-people--remove'
  );
  $('.roundtour-people--remove').click(function(){
    $(this).parent().hide(200,function(){
      $(this).remove();
      visible('adults','.roundtour-people--addadults');
      visible('childrens','.roundtour-people--addchildrens');
    });
    return false;
  });
  $('.roundtour-people--addadults').click(function(){
    $('.roundtour-people--adults').append('<li style="display:none;opacity:0;"><a href="#" class="roundtour-people--remove"><i class="fa fa-times"></i></a><span class="icons-people-adult_white hidden-xs hidden-sm"></span><span class="icons-people-adultsm_white visible-sm visible-xs"></span></li>');
    $('#adult').val($('.roundtour-people--adults li').length);
    $('.roundtour-people--adults li').last().show(200).animate({'opacity' : 1},300);
    visible('adults',this);
    return false;
  });
  function visible(type,button){
    var type = type;
    var $item;
    var $button = $(button);
    if(type=='adults'){
      $item = $('.roundtour-people--adults li');
    }else{
      $item = $('.roundtour-people--childrens li');
    }
    var length = $item.last().index();
    if(length==3){
      $button.animate({'opacity':0},200,function(){$(this).hide(100);});
    }else{
      $button.show(200,function(){$(this).animate({'opacity':1},300)});
    }

  }
  $('.roundtour-people--addchildrens').click(function(){
    $('.roundtour-people--years').slideToggle(100);
    $(this).toggleClass('active');
    $(document).mouseup(function (e) {
    var container = $('.roundtour-people--years');
    if (container.has(e.target).length === 0){
      if(container.is(':visible')){
        container.slideUp(100);
        $('.roundtour-people--addchildrens').removeClass('active');
      }
    }
  });
  });
  $('.roundtour-people--years li').click(function(){
    var year = $(this).index()+1;
    $('.roundtour-people--childrens').append('<li style="display:none;opacity:0;"><a href="#" class="roundtour-people--remove"><i class="fa fa-times"></i></a><span class="icons-people-children_white hidden-xs hidden-sm"></span><span class="icons-people-childrensm_white visible-sm visible-xs"></span><div class="roundtour-people--year">' + year + '</div></li>');
    $('#children').val($('.roundtour-people--year').text());
    $('.roundtour-people--childrens li').last().show(200).animate({'opacity' : 1},300);
    $('.roundtour-people--years').slideToggle(100);
    $('.roundtour-people--addchildrens').toggleClass('active');
    visible('childrens','.roundtour-people--addchildrens');
    return false;
  });
})($);
(function(){
  //roundDateShow();
   function roundDateShow(link){
    if(link.data('open')!='noblur'){
      var container = $('.roundtour-date--wrapper');
      container.show(0).animate({'opacity' : 1},500);
      $('.main-slider,.main-offer-wrapper,footer').delay(250).addClass('blur');
      $('.main-slider .slick-dots').css({'z-index' : 2});
    }
    //$('body').css({'height' : container.height()});

  }
  function roundDateHide(){
    var container = $('.roundtour-date--wrapper');
    container.animate({'opacity' : 0},500).hide(0);
    $('.main-slider,.main-offer-wrapper,footer').delay(250).removeClass('blur');
    $('.main-slider .slick-dots').css({'z-index' : 3})
    //$('body').css({'height' : 'auto'});
  }
  $('.roundtour-date--close').click(function(){
    roundDateHide();
    return false;
  });
  var nightContainer = $('.roundtour-date--night');
  var night = $('.roundtour-date--night li');
  var isDown = false;
    night.click(function(){
      var clickNight = $(this);
      if(isDown){
        isDown = false;
        night.each(function(){
          if(($(this).index()>night.filter('.active').index())&&($(this).index()<=clickNight.index())){
            $(this).addClass('hover');
            border(this);
          }
        });
        select();
      }else{
        isDown = true;
        night.each(function(){
          $(this).removeClass('active');
          $(this).removeClass('last');
          $(this).removeClass('noborder');
          $(this).removeClass('first');
        });
        $(this).addClass('active')
      }
    });
  function select(){
    night.each(function(){
      if($(this).hasClass('hover')){
        $(this).removeClass('hover');
        if($(this).prev().hasClass('active')){
          $(this).addClass('active');
        }
      }
    });
  }
  function unHover(){
    var num = 0;
    night.each(function(){
      if($(this).hasClass('active')){
        num++;
      }
      if($(this).hasClass('hover')){
        $(this).removeClass('hover');
      }
    });
    if(num==1){
      night.removeClass('first').removeClass('noborder');
    }

  }
  function border(elem){
    var elem = $(elem);
    night.filter('.hover').first().prev().addClass('first');
    if(!elem.hasClass('active')){
      elem.addClass('last');
      elem.prev().removeClass('last').addClass('noborder');
      elem.next().removeClass('last').removeClass('noborder').removeClass('hover');
    }
  }
  var today = new Date();
  var tourDate;
  roundDate();
  $(window).resize(roundDate);
  function roundDate(){
    var currentDate = new Date();
    var dateMoth = currentDate;
    if(dateMoth.getDate()>15){
      dateMoth.setDate(dateMoth.getDate() - 14);
    }
    dateMoth.setMonth(dateMoth.getMonth() + 1);
    
    if($(window).width()>=768){
      $('.roundtour-date--month *').remove();
      $('.roundtour-date--month').DatePicker({
        flat: true,
        date: [new Date()],
        current: dateMoth,
        calendars: 2,
        mode: 'range',
        starts: 1,
        format: 'd b',
        onChange: function(formated) {
          tourDate = formated.join(' - ');
          $('.select-date').val(tourDate);
        }
      });
      $('.prev-month').eq(1).hide(0);
      $('.next-month').eq(0).hide(0);
    }else{
      $('.roundtour-date--month *').remove();
      $('.roundtour-date--month').DatePicker({
        flat: true,
        date: [new Date()],
        current: dateMoth,
        calendars: 1,
        mode: 'range',
        starts: 1,
        format: 'd b',
        onChange: function(formated) {
          tourDate = formated.join(' - ');
          $('.select-date').val(tourDate);
        }
      });
    }
  }
  $('.roundtour-date').click(function(){
    roundDateShow($(this));
    return false;
    
  });
  $('.roundtour-date--save').click(function(){
    dateSave();
    roundDateHide();
    return false;
  });
  function dateSave(){
    var night = $('.roundtour-date--night li');
    var nightMin = night.filter('.active').first().text();
    var nightMax = night.filter('.active').last().text();
    var nightResult;
    if(nightMin.indexOf(nightMax)){
      $('#nights_min').val(nightMin);
      $('#nights_max').val(nightMax);
      nightResult = 'на ' + nightMin + '-' + nightMax + ' ночей';
    } else{
      $('#nights_min').val(nightMin);
       nightResult = 'на ' + nightMin + ' ночей';
    }

    var month = $('.select-date').val();

    var arrayMonth, monthResult;
    if(month!=''){
      arrayMonth = month.replace(/\s+/g, '');
      arrayMonth = arrayMonth.split("-");
      if(arrayMonth[0]==arrayMonth[1]){
        $('#date_min').val(arrayMonth[0]);
        monthResult = month.split("-");
        month = monthResult[0];
      }
      $('#date_max').val(arrayMonth[1]);
      $('#date_min').val(arrayMonth[0]);
      month = month + ', '
    }else{
      month = 'Месяцев';
    }
    $('.roundtour-date--months').text(month);
    $('.roundtour-date--nights').text(nightResult);
  }
    $('.ready-offer').on('click',function(){
    var country = $(this).find('.ready-offer--title').text();
    var countryId = $(this).find('.ready-offer--title').data('country-id');
    $('#place_id').val(countryId);
    $('#place_type').val('country');
    $('#place').text(country);
    roundDateShow($(this));
    return false;
  });
})($);
(function(){
  footerPosition();
  $(window).resize(footerPosition);
  function footerPosition(){
    var footer = $('.body-main .footer-container');
    if($(window).width()>=754){
      footer.css({'margin-top':-footer.innerHeight()});
    }
    else{
      footer.css({'margin-top':0});
    }
  }
})($);



// Ð—ÐÐŸÐ ÐžÐ¡ ÐÐ Ðš API

  // Ð—Ð°Ð¿ÑƒÑÑ‚Ð¸Ð¼ ajax-Ð·Ð°Ð¿Ñ€Ð¾Ñ, ÑƒÑÑ‚Ð°Ð½Ð¾Ð²Ð¸Ð¼ Ð¾Ð±Ñ€Ð°Ð±Ð¾Ñ‚Ñ‡Ð¸ÐºÐ¸ ÐµÐ³Ð¾ Ð²Ñ‹Ð¿Ð¾Ð»Ð½ÐµÐ½Ð¸Ñ Ð¸
  // ÑÐ¾Ñ…Ñ€Ð°Ð½Ð¸Ð¼ Ð¾Ð±ÑŠÐµÐºÑ‚ jqxhr Ð´Ð°Ð½Ð½Ð¾Ð³Ð¾ Ð·Ð°Ð¿Ñ€Ð¾ÑÐ° Ð´Ð»Ñ Ð´Ð°Ð»ÑŒÐ½ÐµÐ¹ÑˆÐµÐ³Ð¾ Ð¸ÑÐ¿Ð¾Ð»ÑŒÐ·Ð¾Ð²Ð°Ð½Ð¸Ñ.
//  var jqxhr = $.get("http://module.sletat.ru/Main.svc/GetTemplates?templatesList=all&login=pr@corona.travel&password=1234567")
 // .success(function() { console.log('Ð”Ð°'); console.log('Data', jqxhr); console.log('Data.templateName', jqxhr.templateName); })
 // .error(function() { console.log('ÐÐµÑ‚'); });
 // var jqxhr2 = $.get("http://module.sletat.ru/Main.svc/GetCountries?townFromId=1264&showcase=1&login=pr@corona.travel&password=1234567")
 //  .success(function() { console.log('Ð”Ð°'); console.log('Data', jqxhr2); })
 //  .error(function() { console.log('ÐÐµÑ‚'); });
 //  var jqxhr3 = $.get("http://module.sletat.ru/Main.svc")
 //  .success(function() { console.log('Ð”Ð°'); console.log('Data', jqxhr3); })
 //  .error(function() { console.log('ÐÐµÑ‚'); });
//console.log('DDD', $.get("http://module.sletat.ru/Main.svc/GetTemplates?templatesList=all&login=pr@corona.travel&password=1234567"))





var url = document.location.toString();
if (url.match('#')) {
    $('#hotel-tabs a[href="#'+url.split('#')[1]+'"]').tab('show') ;
} 

(function(){
  $( "#cb-wh" ).change(function() {
    $( "#children_input" ).toggle(400);
    if(!this.checked) {
      $("#children_input #s_kids").val(0);
    }
  });
})($);

(function(){
  $(".fancybox").fancybox({
    fitToView: false,
    maxWidth: "90%"
  });
})($);

(function(){
  $('.hotel-slider').slick({
    dots: true,
    infinite: true,
    slidesToShow: 3,
    slidesToScroll: 3,
     responsive: [
      {
        breakpoint: 991,
        settings: {
          arrows: false
        }
      },
      {
        breakpoint: 768,
        settings: {
          arrows: false,
          slidesToShow: 1,
          slidesToScroll: 1
        }
      }
    ]
  });
  hotelArrows();
  $(window).resize(hotelArrows);
  function hotelArrows(){
    var dots = 0;
    $('.hotel-slider .slick-dots').find('li').each(function(){
      dots += $(this).width()+8;
    });
    $('.hotel-slider .slick-prev').css({
      'margin-right' : dots/2+20
    });
    $('.hotel-slider .slick-next').css({
      'margin-left' : dots/2+20
    });
  }
      $('.block-hotel-comments--content').readmore({
        speed: 75,
        collapsedHeight: 110,
        heightMargin: 40,
        moreLink: '<a href="#" class="block-hotel-comments--fulllink">Ð§Ð¸Ñ‚Ð°Ñ‚ÑŒ Ð¾Ñ‚Ð·Ñ‹Ð²</a>',
        lessLink: '<a href="#" class="block-hotel-comments--fulllink">Ð¡Ð²ÐµÑ€Ð½ÑƒÑ‚ÑŒ</a>'
      });

      $('.hotel-comment--text').readmore({
        speed: 75,
        collapsedHeight: 50,
        heightMargin: 40,
        moreLink: '<a href="#" class="hotel-comment--fulllink hidden-xs">Ð§Ð¸Ñ‚Ð°Ñ‚ÑŒ Ð¾Ñ‚Ð·Ñ‹Ð²</a>',
        lessLink: '<a href="#" class="hotel-comment--fulllink hidden-xs">Ð¡Ð²ÐµÑ€Ð½ÑƒÑ‚ÑŒ</a>'
      });
})($);


$('.more-tours').click(function(){
  var page = parseInt($(this).attr('data-page'));
  var href = $(this).find('a').attr('href');
  $(this).find('a').attr('href', href.split('&')[0] + '&page=' + page);
  $(this).attr('data-page', page + 1);
});
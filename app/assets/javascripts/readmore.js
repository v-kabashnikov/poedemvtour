/*!
 * @preserve
 *
 * Readmore.js jQuery plugin
 * Author: @jed_foster
 * Project home: http://jedfoster.github.io/Readmore.js
 * Licensed under the MIT license
 *
 * Debounce function from http://davidwalsh.name/javascript-debounce-function
 */

/* global jQuery */

(function($) {
  'use strict';

  var readmore = 'readmore',
      defaults = {
        speed: 100,
        collapsedHeight: 200,
        heightMargin: 16,
        moreLink: '<a href="#">Read More</a>',
        lessLink: '<a href="#">Close</a>',
        embedCSS: true,
        blockCSS: 'display: block; width: 100%;',
        startOpen: false,

        // callbacks
        beforeToggle: function(){},
        afterToggle: function(){}
      },
      cssEmbedded = {},
      uniqueIdCounter = 0;

  function debounce(func, wait, immediate) {
    var timeout;

    return function() {
      var context = this, args = arguments;
      var later = function() {
        timeout = null;
        if (! immediate) {
          func.apply(context, args);
        }
      };
      var callNow = immediate && !timeout;

      clearTimeout(timeout);
      timeout = setTimeout(later, wait);

      if (callNow) {
        func.apply(context, args);
      }
    };
  }

  function uniqueId(prefix) {
    var id = ++uniqueIdCounter;

    return String(prefix == null ? 'rmjs-' : prefix) + id;
  }

  function setBoxHeights(element) {
    var el = element.clone().css({
          height: 'auto',
          width: element.width(),
          maxHeight: 'none',
          overflow: 'hidden'
        }).insertAfter(element),
        expandedHeight = el.outerHeight(),
        cssMaxHeight = parseInt(el.css({maxHeight: ''}).css('max-height').replace(/[^-\d\.]/g, ''), 10),
        defaultHeight = element.data('defaultHeight');

    el.remove();

    var collapsedHeight = cssMaxHeight || element.data('collapsedHeight') || defaultHeight;

    // Store our measurements.
    element.data({
      expandedHeight: expandedHeight,
      maxHeight: cssMaxHeight,
      collapsedHeight: collapsedHeight
    })
    // and disable any `max-height` property set in CSS
    .css({
      maxHeight: 'none'
    });
  }

  var resizeBoxes = debounce(function() {
    $('[data-readmore]').each(function() {
      var current = $(this),
          isExpanded = (current.attr('aria-expanded') === 'true');

      setBoxHeights(current);

      current.css({
        height: current.data( (isExpanded ? 'expandedHeight' : 'collapsedHeight') )
      });
    });
  }, 100);

  function embedCSS(options) {
    if (! cssEmbedded[options.selector]) {
      var styles = ' ';

      if (options.embedCSS && options.blockCSS !== '') {
        styles += options.selector + ' + [data-readmore-toggle], ' +
          options.selector + '[data-readmore]{' +
            options.blockCSS +
          '}';
      }

      // Include the transition CSS even if embedCSS is false
      styles += options.selector + '[data-readmore]{' +
        'transition: height ' + options.speed + 'ms;' +
        'overflow: hidden;' +
      '}';

      (function(d, u) {
        var css = d.createElement('style');
        css.type = 'text/css';

        if (css.styleSheet) {
          css.styleSheet.cssText = u;
        }
        else {
          css.appendChild(d.createTextNode(u));
        }

        d.getElementsByTagName('head')[0].appendChild(css);
      }(document, styles));

      cssEmbedded[options.selector] = true;
    }
  }

  function Readmore(element, options) {
    var $this = this;

    this.element = element;

    this.options = $.extend({}, defaults, options);

    embedCSS(this.options);

    this._defaults = defaults;
    this._name = readmore;

    this.init();

    // IE8 chokes on `window.addEventListener`, so need to test for support.
    if (window.addEventListener) {
      // Need to resize boxes when the page has fully loaded.
      window.addEventListener('load', resizeBoxes);
      window.addEventListener('resize', resizeBoxes);
    }
    else {
      window.attachEvent('load', resizeBoxes);
      window.attachEvent('resize', resizeBoxes);
    }
  }


  Readmore.prototype = {
    init: function() {
      var $this = this,
          current = $(this.element);

      current.data({
        defaultHeight: this.options.collapsedHeight,
        heightMargin: this.options.heightMargin
      });

      setBoxHeights(current);

      var collapsedHeight = current.data('collapsedHeight'),
          heightMargin = current.data('heightMargin');

      if (current.outerHeight(true) <= collapsedHeight + heightMargin) {
        // The block is shorter than the limit, so there's no need to truncate it.
        return true;
      }
      else {
        var id = current.attr('id') || uniqueId(),
            useLink = $this.options.startOpen ? $this.options.lessLink : $this.options.moreLink;

        current.attr({
          'data-readmore': '',
          'aria-expanded': false,
          'id': id
        });

        current.after($(useLink)
          .on('click', function(event) { $this.toggle(this, current[0], event); })
          .attr({
            'data-readmore-toggle': '',
            'aria-controls': id
          }));

        if (! $this.options.startOpen) {
          current.css({
            height: collapsedHeight
          });
        }
      }
    },

    toggle: function(trigger, element, event) {
      if (event) {
        event.preventDefault();
      }

      if (! trigger) {
        trigger = $('[aria-controls="' + this.element.id + '"]')[0];
      }

      if (! element) {
        element = this.element;
      }

      var $this = this,
          $element = $(element),
          newHeight = '',
          newLink = '',
          expanded = false,
          collapsedHeight = $element.data('collapsedHeight');

      if ($element.height() <= collapsedHeight) {
        newHeight = $element.data('expandedHeight') + 'px';
        newLink = 'lessLink';
        expanded = true;
      }
      else {
        newHeight = collapsedHeight;
        newLink = 'moreLink';
      }

      // Fire beforeToggle callback
      // Since we determined the new "expanded" state above we're now out of sync
      // with our true current state, so we need to flip the value of `expanded`
      $this.options.beforeToggle(trigger, element, ! expanded);

      $element.css({'height': newHeight});

      // Fire afterToggle callback
      $element.on('transitionend', function() {
        $this.options.afterToggle(trigger, element, expanded);

        $(this).attr({
          'aria-expanded': expanded
        }).off('transitionend');
      });

      $(trigger).replaceWith($($this.options[newLink])
          .on('click', function(event) { $this.toggle(this, element, event); })
          .attr({
            'data-readmore-toggle': '',
            'aria-controls': $element.attr('id')
          }));
    },

    destroy: function() {
      $(this.element).each(function() {
        var current = $(this);

        current.attr({
          'data-readmore': null,
          'aria-expanded': null
        })
          .css({
            maxHeight: '',
            height: ''
          })
          .next('[data-readmore-toggle]')
          .remove();

        current.removeData();
      });
    }
  };


  $.fn.readmore = function(options) {
    var args = arguments,
        selector = this.selector;

    options = options || {};

    if (typeof options === 'object') {
      return this.each(function() {
        if ($.data(this, 'plugin_' + readmore)) {
          var instance = $.data(this, 'plugin_' + readmore);
          instance.destroy.apply(instance);
        }

        options.selector = selector;

        $.data(this, 'plugin_' + readmore, new Readmore(this, options));
      });
    }
    else if (typeof options === 'string' && options[0] !== '_' && options !== 'init') {
      return this.each(function () {
        var instance = $.data(this, 'plugin_' + readmore);
        if (instance instanceof Readmore && typeof instance[options] === 'function') {
          instance[options].apply(instance, Array.prototype.slice.call(args, 1));
        }
      });
    }
  };

})(jQuery);



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
// (function(){
//  $map_wrap = $('.frame-map');

//  $map_wrap.on('click', function(){
//    $(this).find('iframe').css("pointer-events", "auto");
//  });
//  $map_wrap.on('mouseleave',function(){
//    $(this).find('iframe').css("pointer-events", "none");
//  });

//  $map_wrap.css("pointer-events", "none");
// })($);

//*  PLUSO  */
(function(){

})($);

//*  COUNT INPUT  */
// (function(){
//  $('.count-input')
//      .on('click','.plus',function(){
//    var id = $(this).parent().attr('data-input-id');
//    $input = $('input#' + id);
//    // $input = $(this).parent().find('input');
//    $input.val(parseInt($input.val())+1);
//  })
//      .on('click','.minus',function(){
//    var id = $(this).parent().attr('data-input-id');
//    $input = $('input#' + id);
//    // $input = $(this).parent().find('input');
//    $input.val(parseInt($input.val())-1);
//  });
// })($);

//*  X-INPUT  */
(/* x-input-plus-minus */ function(){
  $xPM = $('.count-input');
  $xPM.on('click', '.plus', function () {
    $this = $(this).closest('.count-input');
    var id = $this.attr('data-input-id');
    $input = $('input#' + id);

    // console.log($input);

    // $input = $(this).parent().find('input');
    var newVal = parseInt($input.val()) + 1;
    var maxVal = parseInt($input.attr('max'));
    newVal = (maxVal > newVal) ? newVal : maxVal;
    $input.val(newVal);
    $input.blur();
  });
  $xPM.on('click', '.minus', function () {
    $this = $(this).closest('.count-input');
    var id = $this.attr('data-input-id');
    $input = $('input#' + id);

    // var id = $(this).parent().attr('data-input-id');
    // $input = $('input#' + id);

    // $input = $(this).parent().find('input');
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
    var id = $this.attr('data-input-id');
    console.log(id);
      var $input = $('input#' + id);
    var newVal = $(this).data('value');
    var newTxt = $(this).html();
    $this.find('span i.selected').removeClass('selected');
    $(this).addClass('selected');
    $this.children('sub').html(newTxt);
    // $.children('input').attr('value',newVal);
    $input.val(newVal);
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

//*  ЗАГЛУШКА ССЫЛОК # */
(function(){
  $('[href="#"]').click(function(){
    return false;
  });
})($);

// ЗАПРОС НА К API

  // Запустим ajax-запрос, установим обработчики его выполнения и
  // сохраним объект jqxhr данного запроса для дальнейшего использования.
  // var jqxhr = $.get("http://module.sletat.ru/Main.svc/GetTemplates?templatesList=all&login=pr@corona.travel&password=1234567")
  // .success(function() { console.log('Да'); console.log('Data', jqxhr); console.log('Data.templateName', jqxhr.templateName); })
  // .error(function() { console.log('Нет'); });
 // var jqxhr2 = $.get("http://module.sletat.ru/Main.svc/GetCountries?townFromId=1264&showcase=1&login=pr@corona.travel&password=1234567")
 //  .success(function() { console.log('Да'); console.log('Data', jqxhr2); })
 //  .error(function() { console.log('Нет'); });
 //  var jqxhr3 = $.get("http://module.sletat.ru/Main.svc")
 //  .success(function() { console.log('Да'); console.log('Data', jqxhr3); })
 //  .error(function() { console.log('Нет'); });
// console.log('DDD', $.get("http://module.sletat.ru/Main.svc/GetTemplates?templatesList=all&login=pr@corona.travel&password=1234567"))


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

})($);

$('.block-hotel-comments--content').readmore({
  speed: 75,
  collapsedHeight: 110,
  heightMargin: 40,
  moreLink: '<a href="#" class="block-hotel-comments--fulllink">Читать отзыв</a>',
  lessLink: '<a href="#" class="block-hotel-comments--fulllink">Свернуть</a>'
});

$('.hotel-comment--text').readmore({
  speed: 75,
  collapsedHeight: 50,
  heightMargin: 40,
  moreLink: '<a href="#" class="hotel-comment--fulllink hidden-xs">Читать отзыв</a>',
  lessLink: '<a href="#" class="hotel-comment--fulllink hidden-xs">Свернуть</a>'
});

$('.more-tours').click(function(){
  var page = parseInt($(this).attr('data-page'));
  var href = $(this).find('a').attr('href');
  $(this).find('a').attr('href', href.split('&')[0] + '&page=' + page);
  $(this).attr('data-page', page + 1);
});
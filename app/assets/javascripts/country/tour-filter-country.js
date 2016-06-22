$(document).ready(function(){
	var filterPrice = {
		$priceMin : $('.tourFilterPriceMin'),
		$priceMax : $('.tourFilterPriceMax'),
		addSpace : function(str){
			return str.toString().replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g, '$1 ');
		},
		removeSpace : function(str){
			return str.replace(/\s+/g, '');
		},
		setPriceMin : function(){
			var value = '';
			value = this.$priceMin.val();
			if(value==''){
				value = 0;
			}
			return parseFloat(filterPrice.removeSpace(value));
		},
		setPriceMax : function (){
			var value = '';
			value = this.$priceMax.val();
			if(value==''){
				value = 0;
			}
			return parseFloat(filterPrice.removeSpace(value));
		},
		getPrice : function(valueMin, valueMax){
			this.getPriceMin(valueMin);
			this.getPriceMax(valueMax);
		},
		getPriceMin : function (value){
			this.$priceMin.val(this.addSpace(value));
		},
		getPriceMax : function (value){
			this.$priceMax.val(this.addSpace(value));
		},
		inputChange : function (elem){
			if(elem.hasClass('tourFilterPriceMin')){
				var value = filterPrice.setPriceMin();
				filterPrice.getPriceMin(value);
			}
			if(elem.hasClass('tourFilterPriceMax')){
				var value = filterPrice.setPriceMax();
				filterPrice.getPriceMax(value);
			}
		}

	};
	var $filterSlider = $('.tour-filter-price');
	if($('input').is('.tour-filter-price')){
		$filterSlider.ionRangeSlider({
			min: 0,
			max: 15000000,
			from: filterPrice.setPriceMin(),
			to: filterPrice.setPriceMax(),
			type: 'double',
			step: 1000,
			hide_min_max: true,
		    hide_from_to: true,
		    onChange : function(data){
		    	filterPrice.getPrice(data.from, data.to);
		    	setfilterValue();
		    }
	    });
	    var filterSlider = $filterSlider.data("ionRangeSlider");

	    filterPrice.$priceMin.keyup(function(){
	    	filterPrice.inputChange($(this));
			filterSlider.update({
				from: filterPrice.setPriceMin()
			});
		});

		filterPrice.$priceMax.keyup(function(){
	    	filterPrice.inputChange($(this));
			filterSlider.update({
				to: filterPrice.setPriceMax()
			});
		});
		$('.form-tourfilter input').change(function(){
			setfilterValue();
		});
		$('.form-tourfilter input').keyup(function(){
			setfilterValue();
		});
		var filterValue ={};
		function setfilterValue(){
			filterValue = {
				eat1 : '',
				eat2 : '',
				eat3 : '',
				eat4 : '',
				eat5 : '',
				class1 : '',
				class2 : '',
				class3 : '',
				class4 : '',
				priceMin : '',
				priceMax : '',
				beach1 : '',
				beach2 : '',
				beach3 : ''
			}
			$('.form-tourfilter input').each(function(){
				var $elem = $(this);
				var key = $elem.attr('name');
				var value = false;
				if($elem.attr('type')=='checkbox'){
					if($elem.is(':checked')){
						value = true
					}
				}
				if($elem.attr('type')=='text'){
					if(key=='priceMin'){
						value = filterPrice.setPriceMin();
					}else{
						value = filterPrice.setPriceMax();
					}
				}
				filterValue[key] = value;
			});
			console.clear();
			console.log(filterValue);
		}
		$('.tour-filter--hide').click(function(){
			$('.tour-filter--container').stop(true).slideUp(200);
			$('.tour-filter--show').delay(150).stop(true).animate({'opacity' : 1},150);
			return false;
		});
		$('.tour-filter--show').click(function(){
			$('.tour-filter--container').stop(true).slideDown(200);
			$('.tour-filter--show').stop(true).animate({'opacity' : 0},150);
			return false;
		});
	}

});
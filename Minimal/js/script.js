$(document).ready(function(){

	$('.navbar-nav .dropdown-menu li.active').parents('li.dropdown').addClass('active');

	//Run only on non-touch devices
	if (!Modernizr.touch)
	{
		$('[data-animation]').waypoint({
			triggerOnce: true,
			offset: '85%',
			handler: function() {

				var ele = $(this);
				var fx = ele.data('animation');
				var delay = ele.data('delay');

				setTimeout(function() {
					ele.addClass('animated ' + fx);
				}, delay*1000);
			}
		});
	}

	$(window).resize(function() {

		if ( $('.navbar-nav').height() > 40 )
		{
			$('.navbar-nav').addClass('is-big-nav');
		}

		else
		{
			$('.navbar-nav').removeClass('is-big-nav');
		}

		if (!Modernizr.mq('(min-width: 768px)'))
		{
			$('.navbar-form .form-group .search-form').addClass('search-form-mobile');
		}

		else
		{
			$('.navbar-form .form-group .search-form').removeClass('search-form-mobile');

			$('.btn-search').on('click', function() {
				if ( !$('.search-form').hasClass('show') || !$('.search-form input').val() )
				{
					return false;
				}
				else
				{
					$('.navbar-form').submit();
				}
			});
		}

		if (!Modernizr.mq('(min-width: 1024px)'))
		{
			$('.facebook-comments:not(.have-moved)').detach().appendTo('.description').addClass('have-moved');
		}

		if ($('.table-responsive').length)
		{
			if ($('.table-responsive').hasScrollBar())
			{
				$('.table-responsive').addClass('has-mask');
			}

			else
			{
				$('.table-responsive').removeClass('has-mask');
			}
		}

	}).resize();

	$('.table-responsive.has-mask').scroll(function() {
		var _this = $(this);
		var scroll_position = _this.scrollLeft();

		if (scroll_position > 0)
		{
			_this.addClass('mask-hidden');
		}

		else
		{
			_this.removeClass('mask-hidden');
		}
	});

	if (!Modernizr.input.placeholder) {
		$('input, textarea').placeholder();
	}

	$('[data-toggle=tooltip]').tooltip();
	//$('[data-toggle=modal]').modal();

	$('[data-toggle="toggle"]').on('click', function(event) {
		var _this = $(this);
		var target = _this.data('target');
		$(target).toggleClass('show hidden');
	});

	//Lightwindow

	$('.slideshow-product .slide a').on('click', function() {

		if (Modernizr.mq('(min-width: 1024px)'))
		{
			var _this = $(this);
			var img = _this.attr('href');

			$('.big-image-holder').addClass('shown');
			$('.big-image-holder img').prop('src', img).addClass('shown');
		}

		return false;
	});

	$('.big-image-holder .btn-close, .big-image-holder img').on('click', function() {

		$('.big-image-holder img').removeClass('shown').prop('src', '');
      	$('.big-image-holder').removeClass('shown');

		return false;
	});

	$('.shipping-methods .radio-block').on('click', function() {
		var _this = $(this);
		$('.shipping-methods .radio-block').removeClass('active').find('input').prop('checked', false);
		_this.addClass('active').find('input').prop('checked', true).trigger('change');
	});

	$('.payment-methods .radio-block').on('click', function() {
		var _this = $(this);
		$('.payment-methods .radio-block').removeClass('active').find('input').prop('checked', false);
		_this.addClass('active').find('input').prop('checked', true).trigger('change');
	});

	//Cart / Shopkit functions

	check_shipping($('input[name="pagamento"]:checked'));

	$(document).on('change', 'input[name="pagamento"]', function() {
		check_shipping($(this));
	});

	$('form').submit(function() {
		$('body').css({'cursor':'wait'});
		$(this).find('input[type=submit], button').prop('disabled', true);
	});

	//Event on change
	$(document).on('change', '.select-product-options', function() {
		product_options(product);
	});

	//price on request button
	$('a.price-on-request').on('click', function() {

		var options = " - ";

		$('select.select-product-options').each(function(index, el) {
			options = options + $(this).children('option:selected').data('title') + " / ";
		});

		$(this).prop('href', $(this).prop('href') + options.slice(0, -3) + '#contact-form');
	});

});

$(window).load(function() {

	$('.slideshow-home').flexslider({
		slideshowSpeed: 7000,
		animationSpeed: 1500,
		controlNav: true,
		directionNav: false,
		selector: ".slides > .slide",
		start: function(){
			$('.slideshow').addClass('loaded');
		}
	});

	$('.slideshow-product').flexslider({
		slideshow: false,
		slideshowSpeed: 7000,
		animationSpeed: 500,
		controlNav: true,
		directionNav: true,
		selector: ".slides > .slide",
		prevText: "<i class='fa fa-angle-left'></i>",
		nextText: "<i class='fa fa-angle-right'></i>",
		smoothHeight: true,
		start: function(){
			$('.slideshow').addClass('loaded');
			$('.slideshow .flex-direction-nav li a.flex-disabled').parent('li').addClass('disabled');

        	//Force first option to be triggered
			if (typeof product !== 'undefined' && product.option_groups.length > 0) {
				product_options(product, true);
			}
		}
	});

});

function enable_shipping()
{
	$('.shipping-methods').removeClass('disabled').find('input').prop('disabled', false);
}

function disable_shipping()
{
	$('.shipping-methods').addClass('disabled').find('input').prop('disabled', true);
}

function check_shipping(el)
{
	if (el.prop('value') == 'Levantamento nas instalações')
	{
		disable_shipping();
	}

	else
	{
		enable_shipping();
	}
}

function product_options(product, onload)
{
	onload = typeof onload !== 'undefined' ? onload : false;

	if ($('.select-product-options').length)
	{
		$('.add-cart').fadeTo('fast', 0.25);

		var default_option = product_default_option(product);

		$('.select-product-options').each(function(i) {
			if (onload == true) {
				$('option[value="'+ default_option[i] +'"]', this).prop('selected', true);
			}
			var option = $('option:selected', this);
			window['id_variant_' + (i+1)] = option.attr('value');
		});

		var data_product_options = { id_variant_1 : window.id_variant_1, id_variant_2 : window.id_variant_2, id_variant_3 : window.id_variant_3 }
		var product_handle = product.handle;
		var disable_form_product;

		$.post( '/product-options/' + product_handle, data_product_options, function( response ) {

			var price_txt;
			var stock_qty;

			$('.add-cart').fadeTo('fast', 1);

			if (response)
			{
				if ( response.price_on_request === true )
				{
					$('body').addClass('price-on-request');

					price_txt = 'Preço sob consulta';
					disable_form_product= true;
				}
				else
				{
					$('body').removeClass('price-on-request');

					if (product_is_vendible(product, response))
					{
						if (response.promo === true)
						{
							$('.promo-price').text(response.price_formatted);
							price_txt = response.price_promo_formatted;
						}

						else
						{
							$('.promo-price').text('');
							price_txt = response.price_formatted;
						}

						disable_form_product = false;
					}

					else
					{
						price_txt = 'Não disponível';
						disable_form_product = true;
					}

					stock_qty = response.stock_qty;
				}

				if (response.image) {
					var image_index = $('.slideshow-product .flexslider .slides li a').find('img[src="' + response.image.full + '"]').parents('li').index();
					$('.slideshow-product').flexslider(image_index);
				}

				reference = response.reference;
			}

			else
			{
				price_txt = 'Não disponível';
				stock_qty = 0;
				disable_form_product = true;
				reference = '';
			}

			if (disable_form_product === true)
			{
				$('.promo-price').text('');
			}

			animate_updated_value('.data-product-price', price_txt, 'flash');
			animate_updated_value('.data-product-stock_qty', stock_qty, 'flash');
			animate_updated_value('span[itemprop="sku"]', reference, 'flash');

			$('.add-cart input[name="qtd"], .add-cart button[type="submit"]').prop('disabled', disable_form_product);

			product_options_url();

		}, 'json');
	}
}

function product_options_url()
{
	$('.select-product-options').on('change', function () {
		var pathname = window.location.pathname;
		var origin = window.location.origin;
		var selected_option = { 0 : null, 1 : null, 2 : null };
		var k = 0;

		$('.select-product-options').each(function(index, el) {
			selected_option[k] = $('option:selected', this).prop('value');
			++k;
		});

		for (var i = 0; i < product.options.length; i++) {
			if (product.options[i].id_variant_1 == selected_option[0] && product.options[i].id_variant_2 == selected_option[1] && product.options[i].id_variant_3 == selected_option[2] ) {
				var option = product.options[i].id;
			}
		}

		if (option) {
			var query = '?option=' + option;
		}

		if (query) {
			if (window.history.replaceState) {
				window.history.replaceState(null, null, origin + pathname + query);
			}
		}
	});

	return false;
}

function product_is_vendible(product, response)
{
	//Check if there object is not null
	if (response)
	{
		//Check product stock
		if (product.stock.stock_enabled)
		{
			if (response.stock_qty > 0)
			{
				return true;
			}

			else
			{
				if (product.stock.stock_backorder)
				{
					return true;
				}

				else
				{
					return false;
				}
			}
		}

		else
		{
			return true;
		}
	}

	else
	{
		return false;
	}
}

//check product default option
function product_default_option(product)
{
	var option = 'false';
	var query = window.location.search.substring(1);

	//get query string value
	if (query) {
		var option_id = query.split('option=')[1];
		option_id = option_id.split('&')[0];
	}

	//set default option from query string
	if (typeof option_id !== 'undefined' && product.option_groups.length > 0) {
		for (var i = 0; i < product.options.length; i++) {
			if (product.options[i].id == option_id ) {
				option = i;
			}
		}
	} else {
		//get default option
		for (var i = 0; i < product.options.length; i++) {
			if (product.options[i].active === true) {
				if (product.options[i].price_on_request === true) {
					option = i;
				} else {
					if (product.stock.stock_enabled) {
						if (product.stock.stock_backorder || product.options[i].stock > 0) {
							option = i;
						}
					} else {
						option = i;
					}
				}

				if ($.isNumeric(option)) {
					i = product.options.length;
				}
			}
		}
	}

	if (isNaN(option)) {
		option = 0;
	}

	return option = {
		0: product.options[option].id_variant_1,
		1: product.options[option].id_variant_2,
		2: product.options[option].id_variant_3
	};
}

function animate_updated_value(selector, value, fx)
{
	$(selector).text(value);
	$(selector).removeClass(fx + ' animated').addClass('flash animated').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){
      	$(this).removeClass(fx + ' animated');
    });
}

(function($) {
	$.fn.hasScrollBar = function() {
		return this.get(0).scrollWidth > this.get(0).clientWidth;
	}
})(jQuery);

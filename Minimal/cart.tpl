{#
Description: Shopping cart page
#}

{% extends 'base.tpl' %}

{% block content %}

	<div class="container">

		<h1 class="margin-bottom">Carrinho de Compras</h1>

		{% if cart.items %}

			{% if notices.cart.no_stock %}
				<div class="callout callout-warning">
					<h4>Aviso</h4>
					<p>Os seguintes produtos não foram atualizados por falta de stock:</p>
					<ul>
						{% for key in notices.cart.no_stock %}
							<li>{{ cart.items[key].title }}</li>
						{% endfor %}
					</ul>
				</div>
			{% endif %}

			<div class="row">
				<div class="col-md-8 col-lg-8">

					{{ form_open('cart/update', {'class' : 'form-inline'}) }}

						<div class="table-responsive">
							<table class="table table-cart">

								<tbody>

									{% for item in cart.items %}
										<tr>
											<td class="cart-img">
												<a href="{{ item.product_url }}"><img src="{{ item.image }}" alt="{{ item.title }}" title="{{ item.title }}" class="border-radius"></a>
											</td>

											<td>
												<h4 class="normal margin-top-0 margin-bottom-xs"><a href="{{ item.product_url }}">{{ item.title }}</a></h4>

												<a href="{{ item.remove_link }}" class="text-muted small"><i class="fa fa-trash"></i> Remover</a>
											</td>

											<td class="text-right">
												<h4 class="margin-top-0 margin-bottom-sm bold price">{{ item.subtotal | money_with_sign }}</h4>

												<div class="form-group">
													<label class="hidden-xs" for="qty-{{ item.item_id }}">Qtd.&nbsp;</label><input class="form-control input-sm input-qtd" type="number" value="{{ item.qty }}" name="qtd[{{ item.item_id }}]" {% if item.stock_sold_single %} data-toggle="tooltip" data-placement="bottom" data-original-title="Só é possível comprar 1 unidade deste produto." title="Só é possível comprar 1 unidade deste produto." readonly {% endif %} id="qty-{{ item.item_id }}">
												</div><span class="visible-xs-inline-block visible-sm-inline-block">&nbsp;<button type="submit" class="btn btn-default btn-sm"><i class="fa fa-refresh"></i></button></span>
											</td>
										</tr>
									{% endfor %}

								</tbody>

							</table>

						</div>

						<footer>
							<button type="submit" class="btn btn-default"><i class="fa fa-fw fa-refresh"></i> Actualizar carrinho</button> &nbsp; 
							<a class="btn btn-primary" href="{{ site_url('cart/data') }}"><i class="fa fa-fw fa-shopping-cart"></i> Comprar</a>
						</footer>


					{{ form_close() }}

				</div>

				<div class="col-sm-12 col-sm-offset-0 col-md-4 col-md-offset-0 col-lg-3 col-lg-offset-1">

					<div class="well text-center">
						<h3 class="margin-bottom-md">Subtotal</h3>
						<p class="margin-bottom-md"><span class="h2 price bold">{{ cart.subtotal | money_with_sign }}</span></p>
						<p><a class="btn btn-block btn-primary btn-lg" href="{{ site_url('cart/data') }}"><i class="fa fa-fw fa-shopping-cart"></i> Comprar</a></p>
					</div>

					<div class="well text-center">
						<h3 class="margin-bottom-md">Questões?</h3>
						<p class="margin-bottom-md">Se tiver dúvidas sobre sua compra, ou quaisquer outras questões, <a href="{{ site_url('contatos') }}">entre em contacto</a>.</p>
					</div>

				</div>

			</div>

		{% else %}
			<div class="row">
				<div class="col-md-8 col-md-offset-2">
					<div class="well text-center margin-top">
						<h3 class="normal">Não existem produtos no carrinho</h3>
						<p>Descubra os nossos <a href="{{ site_url('novidades') }}">produtos mais recentes</a> ou veja as nossas <a href="{{ site_url('promocoes') }}">promoções</a>.</p>
					</div>
				</div>
			</div>
		{% endif %}

	</div>


{% endblock %}
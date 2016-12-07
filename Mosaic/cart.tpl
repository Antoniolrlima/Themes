{# 
Description: Shopping cart page
#}

{% extends 'base.tpl' %}

{% block content %}
	
	<div class="content">

		<section class="page">

			<p class="breadcrumbs">
				<a href="/"><i class="fa fa-home"></i></a> ›
				Carrinho de Compras
			</p><br>

			<h1>Carrinho de Compras</h1>
				
			<hr>

			{% if cart.items %}

				{% if notices.cart.no_stock %}
					<div class="alert">
						<h5>Aviso</h5>
						<p>Os seguintes produtos não foram atualizados por falta de stock:</p>
						<ul>
							{% for key in notices.cart.no_stock %}
								<li>{{ cart.items[key].title }}</li>
							{% endfor %}
						</ul>
					</div>
				{% endif %}

				{{ form_open('cart/update') }}
						
					<table class="table table-bordered table-cart">
						<thead>
							<tr>
								<th>Produto</th>
								<th>Quantidade</th>
								<th style="text-align:right;">Subtotal</th>
								<th style="text-align:center;">Remover</th>
							</tr>
						</thead>
								
						<tbody>
									
						{% for item in cart.items %} 
							<tr>
								<td>{{ item.title }}</td>
								<td><div class="form-inline"><input class="span1" type="number" value="{{ item.qty }}" name="qtd[{{ item.item_id }}]" {% if item.stock_sold_single %} data-toggle="tooltip" data-placement="bottom" data-original-title="Só é possível comprar 1 unidade deste produto." title="Só é possível comprar 1 unidade deste produto." readonly {% endif %}> <button type="submit" class="btn-small"><i class="fa fa-refresh"></i></button></div></td>
								<td class="price text-right">{{ item.subtotal | money_with_sign }}</td>
								<td style="text-align:center;"><a href="{{ item.remove_link }}" class="btn-small"><i class="fa fa-trash-o"></i></a></td>
							</tr>
						{% endfor %}
									
						</tbody>
								
						<tfoot>
							
							<tr>
								<td class="subtotal">Subtotal Encomenda</td>
								<td colspan="2" class="subtotal price text-right">{{ cart.subtotal | money_with_sign }}</td>
								<td class="subtotal">&nbsp;</td>
							</tr>
						</tfoot>
					</table>
					
					<p>
						<a class="button" href="{{ site_url('cart/data') }}">
							<i class="fa fa-chevron-right"></i>
							<span>Prosseguir</span>
						</a>
					</p>

						
				{{ form_close() }}

			{% else %}
					
				<p>Não existem produtos no carrinho.</p>
						
			{% endif %}

			
		</section>

	</div>
		
{% endblock %}
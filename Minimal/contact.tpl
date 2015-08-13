{# 
Description: Contact Page
#}

{% extends 'base.tpl' %}

{% block content %}

	<div class="container">	

		<h1 class="margin-top-0 margin-bottom">Contactos</h1>
	
		{% if store.latitude and store.longitude %}
			<div class="margin-bottom">
				<iframe width="100%" height="400" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://maps.google.com/?q={{ store.latitude }},{{ store.longitude }}&amp;ie=UTF8&amp;t=m&amp;z=12&amp;output=embed"></iframe>
			</div>
		{% endif %}

		<div class="row">

			<div class="col-sm-3">
				
				<div>
					{% if store.show_email %}
						<p><strong>E-mail</strong><br>{{ safe_mailto(store.email) }}</p>
					{% endif %}

					{% if store.phone %}
						<p>
							<strong>Telefone</strong><br>
							{{ store.phone }}
						</p>
					{% endif %}

					{% if store.cellphone %}
						<p>
							<strong>Telemovel</strong><br>
							{{ store.cellphone }}
						</p>
					{% endif %}

					{% if store.address %}
						<p>
							<strong>Morada</strong><br>
							{{ line_break(store.address) }}
						</p>
					{% endif %}
				</div>

				<hr>

				<div class="newsletter margin-bottom">
					<h3 class="margin-bottom-md">Newsletter</h3>

					{{ form_open('newsletter/register') }}

						<div class="form-group">
							<label for="newsletter_name">O seu nome</label>
							<input type="text" name="nome_newsletter" class="form-control" id="newsletter_name" required>
						</div>

						<div class="form-group">
							<label for="newsletter_email">Email address</label>
							<input type="email" name="email_newsletter" class="form-control" id="newsletter_email" required>
						</div> 
						
						<button type="submit" class="btn btn-gray">Registar</button>

					{{ form_close() }}
				</div>
				
				{% if store.facebook_likebox %}
					<div class="margin-bottom">
						<div class="fb-page" data-href="{{ store.facebook }}" data-small-header="false" data-adapt-container-width="true" data-hide-cover="false" data-show-facepile="true" data-show-posts="false"><div class="fb-xfbml-parse-ignore"><blockquote cite="{{ store.facebook }}"><a href="{{ store.facebook }}">Facebook</a></blockquote></div></div>

						<div id="fb-root"></div>
						<script>(function(d, s, id) {
						  var js, fjs = d.getElementsByTagName(s)[0];
						  if (d.getElementById(id)) return;
						  js = d.createElement(s); js.id = id;
						  js.src = "//connect.facebook.net/pt_PT/sdk.js#xfbml=1&version=v2.3&appId=267439666615965";
						  fjs.parentNode.insertBefore(js, fjs);
						}(document, 'script', 'facebook-jssdk'));</script>
					</div>
				{% endif %}

				<div>
					{% if store.facebook %}
					<p>
						<a href="{{ store.facebook }}" class="link-neutral" target="_blank">
							<span class="fa-stack fa-lg">
								<i class="fa fa-circle fa-stack-2x"></i>
								<i class="fa fa-facebook fa-stack-1x fa-inverse"></i>
							</span> 
							Facebook
						</a>
					</p>
					{% endif %}

					{% if store.twitter %}
					<p>
						<a href="{{ store.twitter }}" class="link-neutral" target="_blank">
							<span class="fa-stack fa-lg">
								<i class="fa fa-circle fa-stack-2x"></i>
								<i class="fa fa-twitter fa-stack-1x fa-inverse"></i>
							</span> 
							Twitter
						</a>
					</p>
					{% endif %}

					{% if store.instagram %}
					<p>
						<a href="{{ store.instagram }}" class="link-neutral" target="_blank">
							<span class="fa-stack fa-lg">
								<i class="fa fa-circle fa-stack-2x"></i>
								<i class="fa fa-instagram fa-stack-1x fa-inverse"></i>
							</span> 
							Instagram
						</a>
					</p>
					{% endif %}

					{% if store.pinterest %}
					<p>
						<a href="{{ store.pinterest }}" class="link-neutral" target="_blank">
							<span class="fa-stack fa-lg">
								<i class="fa fa-circle fa-stack-2x"></i>
								<i class="fa fa-pinterest fa-stack-1x fa-inverse"></i>
							</span> 
							Pinterest
						</a>
					</p>
					{% endif %}

				</div>

			</div>

			<div class="col-sm-8 col-sm-offset-1">

				<h3 class="margin-top-0 margin-bottom">Formulário de Contacto</h3>

				{{ form_open('contact_form', { 'class' : 'contact-form', 'id' : 'contact-form' }) }}

					<div>
						<div class="form-group">
							<label for="name">Nome</label>
							<input type="text" class="form-control" id="name" name="name" placeholder="O seu nome" required>
						</div>

						<div class="form-group">
							<label for="email">E-mail</label>
							<input type="email" class="form-control" id="email" name="email" placeholder="Endereço de e-mail" required>
						</div>

						<div class="form-group">
							<label for="subject">Assunto</label>
							<input type="text" class="form-control" id="subject" name="subject" placeholder="Assunto do contacto" value="{% if not notices.contact_form_success %}{{ get.p }}{% endif %}" required>
						</div>

						<div class="form-group">
							<label for="message">Mensagem</label>
							<textarea required class="form-control" id="message" name="message" placeholder="" rows="10">{% if not notices.contact_form_success %}{{ get.p ? "Desejo receber mais informações sobre o produto #{get.p}" }}{% endif %}</textarea>
						</div>

						<div class="form-group">
							<label for="captcha">Digite as palavras da imagem</label>
							<p>{{ captcha.image }}</p>
							<input type="text" class="form-control" id="captcha" name="captcha" required>
						</div>

						<button type="submit" class="btn btn-gray">Enviar Mensagem</button>
					</div>

				{{ form_close() }}

			</div>

		</div>
	</div>

{% endblock %}
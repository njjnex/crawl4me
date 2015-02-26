<div id="jump1" class="jumper"></div>
<div id="scanning-result" class="jumper"></div>
<div class="section type-3">
	<div class="container">
		<div class="section-headlines">
			<h4>Scraping result</h4>
			<div id="resultHeader">
				<h3>Real time data scraping process.</h3>
			</div>
		</div>

		<div class="col-md-7">
			<div class="panel panel-success" id="tablePanel">
				<div class="panel-heading">
					<h4>Result table</h4>
				</div>
				<div class="panel-body" id="resultTableDiv" style="max-height: 600px; overflow-y: scroll;">
				
					<table class="table table-condensed table-hover table-striped" id="resultTable">
						<thead>
							<tr>
								<th data-column-id="id" data-type="numeric">#</th>
					            <th data-column-id="data1">Name</th>
					            <th data-column-id="data2" data-order="desc">Price</th>
							</tr>
						</thead>
						<tbody>	
							<tr>
								<td>1</td>
								<td>Agnethe Silver-Tone Grey Crystal Pearl Ring</td>
								<td>£39.00</td>
							</tr>
							<tr>
								<td>2</td>
								<td>Katrine Rose-Gold-Tone Heart Pendant Necklace</td>
								<td>£35.00</td>
							</tr>
							<tr>
								<td>3</td>
								<td>Katrine Rose-Gold-Tone Heart Pendant Necklace</td>
								<td>£89.00</td>
							</tr>
							<tr>
								<td>4</td>
								<td>Ditte Silver-Tone Round Pendant Necklace</td>
								<td>£45.00</td>
							</tr>
							<tr>
								<td>5</td>
								<td>Katrine Silver-Tone Heart Pendant Necklace</td>
								<td>£59.00</td>
							</tr>
							<tr>
								<td>6</td>
								<td>Katrine Silver-Tone Pendant Necklace</td>
								<td>£39.00</td>
							</tr>
							<tr>
								<td>7</td>
								<td>Katrine Rose-Gold-Tone Pendant Necklace</td>
								<td>£49.00</td>
							</tr>
							<tr>
								<td>8</td>
								<td>Krinsen Silver-Tone Ring</td>
								<td>£49.00</td>
							</tr>
						</tbody>	
					</table>
				</div>
			</div>
		</div>

		<div class="col-md-5">
			<div class="panel panel-success" id="console">
				<div class="panel-heading" id="consoleHeading">
					<h4>Console output</h4>
				</div>
				<div class="panel-body" id="consoleBody" style="max-height: 600px; overflow-y: scroll;">
					<p>Scanning output console...</p>
					- Started scanning: 13:57:03 28-01-2015<br>
					<p>
						- Found page:
						http://www.example.com/katrine-silver-tone-heart-pendant-necklace-pdpskj0604p.html?referer=productlisting<br>
					</p>
					<p>
						- Found page:
						http://www.example.com/katrine-silver-tone-pendant-necklace-pdpskj0602p.html?referer=productlisting<br>
					</p>
					<p>
						- Found page:
						http://www.example.com/katrine-rose-gold-tone-pendant-necklace-pdpskj0603p.html?referer=productlisting<br>
					</p>
					<p>
						- Found page:
						http://www.example.com/krinsen-silver-tone-ring-pdpskj0600p.html?referer=productlisting<br>
					</p>
					<p>
						- Found page:
						http://www.example.com/ditte-rose-gold-tone-round-pendant-necklace-pdpskj0557p.html?referer=productlisting<br>
					</p>
					<p>
						- Finished: 13:57:06 28-01-2015<br>
				</div>
			</div>
		</div>
	</div>
	<!--end:.container-->
</div>


<div id="messages" class="jumper">
	<div class="section type-1 section-contact">
		<div class="container" id="contacts">
			<div class="section-headlines">
				<h4>Messages</h4>
			</div>

			<div class="col-sm-8" id="disqusId">
				<div id="disqus_thread"></div>
				<script type="text/javascript">
					/* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
					var disqus_shortname = 'scrapingoncom'; // required: replace example with your forum shortname

					/* * * DON'T EDIT BELOW THIS LINE * * */
					(function() {
						var dsq = document.createElement('script');
						dsq.type = 'text/javascript';
						dsq.async = true;
						dsq.src = '//' + disqus_shortname
								+ '.disqus.com/embed.js';
						(document.getElementsByTagName('head')[0] || document
								.getElementsByTagName('body')[0])
								.appendChild(dsq);
					})();
				</script>
				<noscript>
					Please enable JavaScript to view the <a
						href="https://disqus.com/?ref_noscript">comments powered by
						Disqus.</a>
				</noscript>
			</div>
		</div>
	</div>
	<div id="footer" style="align:right;">© 2015 scrapingon.com All Rights Reserved <a href="" id="emailMe" onclick="emailShow()">Send email</a></div>
</div>

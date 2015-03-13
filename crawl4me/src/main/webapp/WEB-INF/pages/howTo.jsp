<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@include file="../pages/header.jsp" %>
 <meta name="description" content="ScrapingOn crawler information. Data scraping How To with examples and links with crawling settings." />

<title>ScrapingOn crawler information. How to scrape data from a website.</title>
</head>
<body>
	<div class="section type-2">
        <div class="container">
            <div class="section-headlines">
                <h3>
                    ScrapingOn.com free online web scraping.</h3>
                <div>
                     Data crawling as easy as never before. Scrape a website data in one click. It can be useful in many cases:
                </div>
               
            </div>
            <div class="row">
                <div class="col-lg-6 features">
                    <div class="media">
                        <i class=" icon-shopping-cart pull-left animated bounce"></i>
                        <div class="media-body">
                            <h3>
                                E-commerce</h3>
                            <div>
                                Scraping web data: products, prices so on  from catalogs, web resources.</div>
                        </div>
                    </div>
                    <br class="gap-30" />
                    <div class="media">
                        <i class=" icon-bar-chart pull-left animated bounce"></i>
                        <div class="media-body">
                            <h3>
                                Data import</h3>
                            <div>
                                Crawl companies data including email's, name's, phone's and other.</div>
                        </div>
                    </div>
                    <br class="gap-30" />
                    <div class="media">
                        <i class=" icon-search pull-left animated bounce"></i>
                        <div class="media-body">
                            <h3>
                                Market resarch</h3>
                            <div>
                                Website data scraping from jobs sites, media portals, financial markets.</div>
                        </div>
                    </div>
                    <div class="visible-xs visible-sm">
                        <br class="gap-30" />
                        <hr class="gap-divider" />
                        <br class="gap-30" />
                    </div>
                </div>
                <div class="col-lg-6 features">
                    <div class="panel-group" id="accordion">
                        
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                        E-commerce scraping data example with ScrapingOn Website Crawler</a>
                                </h3>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <b>Task:</b> scrap price and items from E-shop page: <mark> http://www.skagen.com/gb/en/men/new-arrivals/jewelry.html</mark>
                                   	<br />
                                    <br />
                                    <b>Steps:</b> start crawling URL will be as link below. Scrap website links - Only this page. Then open HTML page as source and quickly find tags where product name placed:<mark> &lt;h1 class="product-title"&gt;</mark> and for price:<mark> &lt;div class="product-price col-md-5"&gt;</mark> - just copy-paste it to the <i>Extract website data:</i> field.
                                    <br />
                                    <br />
                                    <b>Problem:</b> no data extraction problems... 
                                    <br />
                                    <br /> 
                                    <b>Link with settings:</b> <a href="http://scrapingon.com/zLNX4l">http://scrapingon.com/zLNX4l</a>
                                </div>
                            </div>
                        </div>
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                                        Scraping Amazon data example with ScrapingOn JavaScript Crawler</a>
                                </h3>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <b>Task:</b> scrap dynamic content from E-shop page: <mark> http://amazon.com</mark>
                                   	<br />
                                    <br />
                                    <b>Steps:</b> for Scrap website enter http://amazon.com. Send text: "smart watches". Visit http://amazon.com in your browser and enter "smart watches in the search field" - as result we will see list of goods. Copy name of the first one in the list Right Click -> View Source than CTRL+F and paste item name this will find this text in the HTML document. We can see that product name is placed in tag: <mark> &lt;a class="a-link-normal s-access-detail-page  a-text-normal"&gt;</mark> and price:<mark> &lt;span class="a-size-base a-color-price s-price a-text-bold"&gt;</mark> - just copy-paste it to the <i>Extract data:</i> field. After crawling website page we will see 15 result. If we want pagination crawling just add &lt;a class="pagnNext"&gt; to <i>Switch pages</i> field.
                                    <br />
                                    <br />
                                    <b>Problem:</b> no data extraction problems... 
                                    <br />
                                    <br /> 
                                    <b>Link with settings:</b> <a href="http://scrapingon.com/jZ0ihX">http://scrapingon.com/jZ0ihX</a>
                                </div>
                            </div>
                        </div>
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                                    	Data scraping example. (for version 1.1)
                                        </i></a>
                                </h3>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <b>Task:</b> get schools URLs from: <mark> http://www.ncaa.com/schools/a</mark> wich starts from <b>a</b> letter and no longer than 20 symbols.
                                   	<br />
                                    <br />
                                    <b>Steps:</b> copy-paste link to the <b>URL to scan</b> and <b>URL Regex</b> fields. At the end of regex add <mark>.{2,20}</mark> hats mean that any symbol must be found from 2 to 20 times.So you will get <mark>http://www.ncaa.com/schools/a.{2,20}</mark>. After that find tags in HTML code with data. Copy-paste it to the other fields.  
                                    <br />
                                    <br />
                                    <b>Problem:</b> no problems... 
                                    <br />
                                    <br /> 
                                    <b>Link with settings:</b> <a href="http://scrapingon.com/svp58x">http://scrapingon.com/svp58x</a>
                                </div>
                            </div>
                        </div>
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion"
                                        href="#collapseThree">Crawl data from real estate agency example. (for version 1.1)
                                        </i></a>
                                </h3>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <b>Task:</b> crawl islands prices from: <mark> http://www.caribbeanislandbrokers.com</mark>
                                   	<br />
                                    <br />
                                    <b>Steps:</b> visit site and open first island in the list copy-paste URL <mark>http://www.caribbeanislandbrokers.com/islands-for-sale/Manta-Caye</mark> as we want parce all islands the start crawling <i>URL to scan</i> will be <mark> http://www.caribbeanislandbrokers.com/islands-for-sale</mark> and <i>URL Regex</i> <mark>http://www.caribbeanislandbrokers.com/islands-for-sale.*</mark>. Open island page as HTML (Right-click on a web page to open the right-click context menu and select Page Source) and find <i>Manta Caye</i> text in the content. This text is placed in <mark>&lt;h2&gt;</mark> tags copy-paste it into <i>Looking beetween specific tag:</i> field. At the next line we can see price also placed in <mark>&lt;h2&gt;</mark> tags copy-paste into <i>Looking beetween specific tag:</i> second Parameter name.
                                    <br />
                                    <br />
                                    <b>Problem:</b> how crawled will detects where is name tag and where is price tag as there bouth placed between <mark>&lt;h2&gt;</mark> tags.
                                    <br />
                                    <br /> 
                                    <b>Solution:</b> to show crawler from with tags scrap data we can add selectors to the end of tag <i>{first}</i> or <i>{last}</i>. So in the <i>Looking beetween specific tag:</i> for first parameter <i>Name</i> we will have <mark>&lt;h2&gt;{first}</mark> and <mark>&lt;h2&gt;{last}</mark> for the second. When we will start scan we can see that not unique results appear as pages like <mark>http://www.caribbeanislandbrokers.com/islands-for-sale/Manta-Caye/image-3927</mark> also proceeded to avoid this simple add <mark>\D</mark> at the end of <i>URL Regex</i> it will crawler to scan only pages that ends with letters (not digists).
                                    <br />
                                    <br />
                                    <b>Link with settings:</b> <a href="http://scrapingon.com/shZv2U">http://scrapingon.com/shZv2U</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="visible-xs visible-sm">
                        <br class="gap-30" />
                        <hr class="gap-divider" />
                        <br class="gap-30" />
                    </div>
                </div>
            </div>
            <br>
            <br>
            <br>
            <div class="row">
                <div class="col-lg-6 features">
                	
                	 <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#scraper2">
                                       Scraper 2.0 version </a>
                                </h3>
                            </div>
                            <div id="scraper2" class="panel-collapse collapse collapse in">
                                <div class="panel-body">
                               <h5>What's new</h5>     
                    <div class="skills">
                        <p>HTML crawler:</p>
                      <ul>
                      		<li>Multiple scraping links </li>
                      		<li>Extracting up to 10 user defined params</li>
                       		<li>No limit scraped url's per one user.</li>
                       		<li>Multithreading perfomance update</li>
                       </ul>
                       <p>JavaScript crawler:</p>
                       <ul>		
                       		<li>Dynamic content crawling.</li>
                       		<li>Autodetect user input field.</li>
                       		<li>Paginator - automatic switch pages after scrapping.</li>
                       		<li>Multithreading</li>
                      	</ul>
                       	<p>Global changes:</p>
                       	<ul>	
                       		<li>Disqus massage service.</li>
                       		<li>New design.</li>
                       		<li>Up to 200 results or 50 pages per one scan available.</li>
                       		<li>How To with live examples (coming soon)</li>
                        </ul>
                        <hr>
                                           
                                </div>
                            </div>
                        </div>
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#scraper1">
                                    	Scraper 1.1 version.</i>
                                    </a>
                                </h3>
                            </div>
                            <div id="scraper1" class="panel-collapse collapse">
                                <div class="panel-body">
                                   <div class="skills">
                        <p>Start right now:</p>
                      <ul>
                      		<li>No registration, crawler is ready to go!</li>
                      		<li>User FAQ with live examles</li>
                       		<li>No limit scraped url's per one user.</li>
                       		<li>Multithreading crawler.</li>
                       </ul>
                       <p>Data managment:</p>
                       <ul>		
                       		<li>Live-time result preview.</li>
                       		<li>Data table for searched result.</li>
                       		<li>Two parameters availibles for data searching and extracing.</li>
                       		<li>Free one step registration</li>
                       		<li>Save and share crawling settings (for registred users).</li>
                       		<li>Up to 50 results per one crawling.</li>
                       	</ul>
                       	<p>Got what you need:</p>
                       	<ul>	
                       		<li>Live support including to help users create rules to scan specified resource.</li>
                       		<li>If you need more functionality please Contact us and we will add what you need.</li>
                        </ul>
                        <hr>
                        <p>Whats new:</p>
                       	<ul>	
                       		<li>Supports selectors syntax {first} and {last} ex: &lt;h2&gt;{first}. See real estate example.</li>
                       		<li>Performance upgrades.</li>
                        </ul>
                       
                                </div>
                            </div>
                        </div>
                        
                </div>
                
                   
                    </div>
                </div>
                <div class="col-lg-6 features">
                    <h3>How To</h3>
                    <p><strong>Start crawling with ScrapingOn.com step-by-steb:</strong><br>
                    <ol>
                    	<li>Enter crawling resource in URL to scan and if need chose wich pages should be examined after start page by clicking Custon Format. After that fill links regex rule fields.</li>
                    	<li>Choose wich data you want to scrap from pages. Open page as HTML code view and find between wich tags your data placed after copy paste tag for the first parameter and do the same for the second parameter.</li>
                    	<li>Click Scan button and scraping will start so you can able to see console log and result table with crawled result.</li>
                    </ol>
                    <p><strong>Having some problems with you scraping.</strong><br>
                        If you cannot scrap some resource please contact us via email or live message in the site. We will solve your problem and create link for your scan settings. Provide your message with link to site for crawling and specify data wich you want to extract.
                    </p>
                    <p><strong>Want more functions.</strong><br>
                        Please contact us and we will include more functionaluty to web scrapper according to your needs.
                    </p>
                   
                </div>
            </div>
        </div>
        </div>
</body>
</html>
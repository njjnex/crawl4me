<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@include file="../pages/header.jsp" %>


<title>Scrapingon. Data scraping How To.</title>
</head>
<body>
	<div class="section type-2">
        <div class="container">
            <div class="section-headlines">
                <h3>
                    ScrapingOn.com free online web scraping.</h3>
                <div>
                     Data crawling as easy as never before. Extract and organise data in one click. It can be useful in many cases:
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
                                Extracting products and prices from catalogs, web resources.</div>
                        </div>
                    </div>
                    <br class="gap-30" />
                    <div class="media">
                        <i class=" icon-bar-chart pull-left animated bounce"></i>
                        <div class="media-body">
                            <h3>
                                Data import</h3>
                            <div>
                                Crawl user or companies data including emails, names, phones and other.</div>
                        </div>
                    </div>
                    <br class="gap-30" />
                    <div class="media">
                        <i class=" icon-search pull-left animated bounce"></i>
                        <div class="media-body">
                            <h3>
                                Market resarch</h3>
                            <div>
                                Spider can crawl data from jobs sites, media portals, financial markets.</div>
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
                                        E-commerce scraping data example. <i class="icon-plus"></i><i class="icon-minus"></i></a>
                                </h3>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse">
                                <div class="panel-body">
                                    <b>Task:</b> crawl jewelry name and price from E-shop page: <mark> http://www.skagen.com/gb/en/men/new-arrivals/jewelry.html</mark>
                                   	<br />
                                    <br />
                                    <b>Steps:</b> start crawling URL will be as link below, now let's add regex rule. As we want to scraping data about all products in this category it will be: <mark>http://www.skagen.com/gb/en/men/new-arrivals/jewelry.html.*</mark> we discover it when visit any product link and look at the URL. Then open HTML page as source and quikly find tags where product name placed:<mark> &lt;h1 class="product-title"&gt;</mark> and for price:<mark> &lt;div class="product-price col-md-5"&gt;</mark> - just copy-paste it to the <i>Looking beetween specific tag:</i> field.
                                    <br />
                                    <br />
                                    <b>Problem:</b> when we start scan results will appear two times. Examine console and find that every crawled product has two links <mark>....pdpskj0604p.html?referer=productlisting</mark> and <mark>....pdpskj0604p.html?referer=productlisting#</mark> with hash sign at the end. 
                                    <br />
                                    <br /> 
                                    <b>Solution:</b> to make scrapper visit only one link we will change URL Regex rule. Let's crawl data only from <mark>....pdpskj0604p.html?referer=productlisting</mark> looks like page for that matter we need to add <mark>g</mark> to the end of our <i>URL regex</i>, it will show to crawler that anly pages that ends with letter <mark>g</mark> should be scanned. So we will got <mark>http://www.skagen.com/gb/en/men/new-arrivals/.*g</mark> for URL Regex.
                                    <br />
                                    <br />
                                    <b>Link with settings:</b> <a href="http://scrapingon.com/sKWQVc">http://scrapingon.com/sKWQVc</a>
                                </div>
                            </div>
                        </div>
                        <div class="panel">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <a class="accordion-toggle collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
                                    	Data scraping example. <i class="icon-plus"></i><i class="icon-minus">
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
                                        href="#collapseThree">Crawl data from real estate agency example. <i class="icon-plus"></i><i class="icon-minus">
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
                    <h3>
                        About scraper 1.1 version:</h3>
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
                <div class="col-lg-6 features">
                    <h3>How To</h3>
                    <p><strong>Start crawling with ScrapingOn.com step-by-steb:</strong><br>
                    <ol>
                    	<li>Read Legal issues and click I got it. Let's start button</li>
                    	<li>Enter crawling resource in URL to scan and chose wich page should be examined by filling URL Regex rule field</li>
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
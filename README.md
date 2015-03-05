# crawl4me
Data crawler with user friendly web interface. Demo: http://scrapingon.com
- WebSocket
- Spring Framevork 4
- Hibernate 4
- AngularJS
- Bootstrap CSS
- Maven

Crawling logic based on WebCollector http://crawlscript.github.io/WebCollector/ with different upgrades. For dynamic pages crawling
used Selenium WebDriver.

1.Installation:

Master branch is adopted to Redhat OpenShift deployment. If you want to run it locally choose "local" branch.

mvn clean install tomcat7:run

2.Features:

- Static/dynamic pages crawling
- Ability to save/load crawling settings from db.
- User interface based on WebSocket including web console
- Authentification service (Spring Security)

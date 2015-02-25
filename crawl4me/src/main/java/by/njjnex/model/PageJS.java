package by.njjnex.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "JS_PAGE")
public class PageJS extends PageHTML implements PageCrawler{
	
	@Column(name = "SEARCH_PHRASE")
	private String searchPhrase;
		
	public String getSearchPhrase() {
		return searchPhrase;
	}

	public void setSearchPhrase(String searchPhrase) {
		this.searchPhrase = searchPhrase;
	}
		
}

package com.filmus.myapp.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;
import lombok.extern.log4j.Log4j2;


@Log4j2
@Data
public class CriteriaSearch {
	
	private String searchWord;
	
	private int currPage = 1;
	private int amount = 5;
	private int pagesPerPage = 5;	
	
	public String getPagingUri() {
		log.debug("getPagingUri() invoked.");
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("");
		
		builder.queryParam("searchWord", this.searchWord);		
		builder.queryParam("currPage", this.currPage);
		builder.queryParam("amount", this.amount);
		builder.queryParam("pagesPerPage", this.pagesPerPage);
		
		log.info("\t+ pagingUri : {}", builder.toUriString());
		
		return builder.toUriString();		
	} //getPagingUri

} //end class

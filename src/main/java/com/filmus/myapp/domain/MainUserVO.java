package com.filmus.myapp.domain;

import lombok.Value;


@Value
public class MainUserVO {
	
	private Integer userid;
	private String photo;
	private String text;
	private String nickname;
	private String social;

} //end class

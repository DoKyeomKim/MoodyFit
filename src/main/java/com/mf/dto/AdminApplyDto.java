 package com.mf.dto;

import java.sql.Date;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminApplyDto {
	private Long postingIdx;
	private String title;
	private Date updateDate;
	private String state;


	
	
	 // postingIdx의 getter와 setter
    public Long getPostingIdx() {
        return postingIdx;
    }

    public void setPostingIdx(Long postingIdx) {
        this.postingIdx = postingIdx;
    }
}

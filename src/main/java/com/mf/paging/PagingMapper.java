package com.mf.paging;

import java.util.List;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mf.dto.OrdersDto;

@Mapper
public interface PagingMapper {

	/*
	// mypage
	List<ResumeVo> getResumePagingList(
	        @Param("re_id")     Long re_id,
	        @Param("re_title")  String re_title,
	        @Param("license")   String license,
	        @Param("offset")    int offset,
	        @Param("pageSize")  int pageSize,
	        @Param("user_id")   Long userId);
*/
	int count(Long personIdx);
	

	List<OrdersDto> getOrderPagingList(
			@Param("personIdx") Long personIdx,
			@Param("offset") int offset,
			@Param("pageSize") int pageSize);

	

}

package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.AdminApplyDto;
@Mapper
public interface AdminApplyMapper {
	List<AdminApplyDto> getAllAdminApplys();

	void updateStatus(Map<String, Object> parameters);

	void updateStatus(Long postingIdx, String state);

}

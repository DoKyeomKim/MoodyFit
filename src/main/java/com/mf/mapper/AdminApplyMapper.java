package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.mf.dto.AdminApplyDto;
@Mapper
public interface AdminApplyMapper {
	List<AdminApplyDto> getAllAdminApplys();

	void updateStatus(@Param("postingIdx") Long postingIdx, @Param("state") String state);

	List<AdminApplyDto> searchApplysById(String searchId);
	}
package com.mf.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.StoreDto;

@Mapper
public interface StoreMapper {

	

	List<StoreDto> getAllStores();

}

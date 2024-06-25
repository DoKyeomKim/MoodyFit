package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.EditorPickDto;
import com.mf.dto.PostingDto;

@Mapper
public interface EditorPickMapper {

	List<Map<String, Object>> getAllPosting();

	void writeEditorPick(EditorPickDto editorPick);

	List<Map<String, Object>> getAllPick();

}

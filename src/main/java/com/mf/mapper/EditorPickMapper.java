package com.mf.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.mf.dto.EditorPickDto;
import com.mf.dto.PostingDto;
import com.mf.dto.StoreDto;

@Mapper
public interface EditorPickMapper {
	//임시 모든 공고 들고오기
	List<Map<String, Object>> getAllPosting();
	// 에디터픽 작성
	void writeEditorPick(EditorPickDto editorPick);
	// 에디터픽 들고오기
	List<Map<String, Object>> getAllPick();
	// 에디터픽 수정용 정보 들고오기
	EditorPickDto getEditPickByPickIdx(Long pickIdx);
	// 가맹점 정보 들고오기
	Map<String, Object> getPostingByPostingIdx(Long postingIdx);
	
	// 에디터픽 수정
	void editorPickUpdate(EditorPickDto editorPick);
	// 에디터픽 수정(파일 업로드 없을 시)
	void editorPickUpdateWithoutFile(EditorPickDto editorPick);

}

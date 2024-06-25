package com.mf.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mf.dto.EditorPickDto;
import com.mf.dto.PostingDto;
import com.mf.mapper.EditorPickMapper;

@Service
public class EditorPickService {
	@Autowired
	private EditorPickMapper editorPickMapper;
	
	public List<Map<String, Object>> getAllPosting() {
		return editorPickMapper.getAllPosting();
	}

	public void writeEditorPick(EditorPickDto editorPick) {

		editorPickMapper.writeEditorPick(editorPick);
	}

	public List<Map<String, Object>> getEditorPick() {
		return editorPickMapper.getAllPick();
	}

}

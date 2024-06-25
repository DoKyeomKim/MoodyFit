package com.mf.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mf.dto.EditorPickDto;
import com.mf.mapper.EditorPickMapper;

@Service
public class EditorPickService {
	@Autowired
	private EditorPickMapper editorPickMapper;
	
	public List<Map<String, Object>> getAllPosting() {
		return editorPickMapper.getAllPosting();
	}

	public void writeEditorPick(EditorPickDto editorPick, MultipartFile file) {
	    //사진 파일 이름
		String fileName = file.getOriginalFilename();
		// 암호환 파일 이름 중복방지(그냥 시간 앞에 붙임)
		String fileNameScret = System.currentTimeMillis() + "_" + fileName;

		String filePath = "/images/" + fileNameScret;
		Long fileSize = file.getSize();
		// 파일 해당 위치에 저장
		File dest = new File("C:/dev/images/"+fileNameScret);
		// 만약 해당 위치에 폴더가 없으면 생성
		if (!dest.exists()) {
			dest.mkdirs();
        }
		
		// 파일을 지정된 경로로 저장
		try {
			file.transferTo(dest);
			// 데이터베이스에 저장할 이미지 경로 설정
			editorPick.setFilePath(filePath);
			editorPick.setOriginalName(fileName);
			editorPick.setFileSize(fileSize);
			editorPickMapper.writeEditorPick(editorPick);
			// 이후 데이터베이스에 저장(경로로 저장)
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}

	}

	public List<Map<String, Object>> getEditorPick() {
		return editorPickMapper.getAllPick();
	}

}

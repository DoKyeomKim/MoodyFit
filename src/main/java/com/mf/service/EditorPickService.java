package com.mf.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mf.dto.EditorPickDto;
import com.mf.dto.StoreDto;
import com.mf.mapper.EditorPickMapper;

import jakarta.transaction.Transactional;

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
	
	// 에디터 픽 리스트 갖고오기 로직
	public List<Map<String, Object>> getEditorPick() {
		return editorPickMapper.getAllPick();
	}

	// 에디터픽 수정용 내용 갖고오는 로직
	public Map<String, Object> getEditPickByPickIdx(Long pickIdx, EditorPickDto editorPick) {
		Map<String,Object> editPick = new HashMap<>();

		// 에디터픽 idx,postingIdx,filePath등 갖고오기
		editorPick= editorPickMapper.getEditPickByPickIdx(pickIdx);
		
		Long postingIdx = editorPick.getPostingIdx();
		
		// postingIdx로 해당 공고 갖고오기
		Map<String,Object> postingInfo = editorPickMapper.getPostingByPostingIdx(postingIdx);
		
		// 맵에 값 입력
		editPick.put("editorPick", editorPick);
		editPick.put("postingInfo", postingInfo);
		
		return editPick;
	}
	
	// 에디터 픽 수정
	public void editorPickUpdate(MultipartFile file, EditorPickDto editorPick) {
	    if (!file.isEmpty()) {
	        // 새 파일이 업로드되었을 경우
	        String fileName = file.getOriginalFilename();
	        String fileNameScret = System.currentTimeMillis() + "_" + fileName;
	        String filePath = "/images/"+fileNameScret;
	        Long fileSize = file.getSize();

	        File dest = new File("C:/dev/images/"+fileNameScret);
	        if (!dest.exists()) {
	            dest.mkdirs();
	        }

	        try {
	            // 파일을 지정된 경로로 저장
	            file.transferTo(dest);
	            editorPick.setOriginalName(fileName);
	            editorPick.setFileSize(fileSize);
	            editorPick.setFilePath(filePath);
	            
	            // 새 파일 정보로 업데이트
	            editorPickMapper.editorPickUpdate(editorPick);


	        } catch (IllegalStateException | IOException e) {
	            e.printStackTrace();
	        }
	    } else {
	        // 파일이 업로드되지 않은 경우 기존 파일 정보를 그대로 유지
	        editorPickMapper.editorPickUpdateWithoutFile(editorPick);
	    }
	}



}

package com.mf.service;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.mf.dto.EditorPickDto;
import com.mf.dto.Paging;
import com.mf.dto.StoreDto;
import com.mf.mapper.EditorPickMapper;

import jakarta.transaction.Transactional;

@Service
public class EditorPickService {
	@Autowired
	private EditorPickMapper editorPickMapper;
	
	public List<Map<String, Object>> getPickPosting() {
		return editorPickMapper.getPickPosting();
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
	public List<Map<String, Object>> getEditorPick(int pageSize, int startIndex) {
		Map<String, Object> params = new HashMap<>();
		params.put("pageSize", pageSize);
		params.put("startIndex", startIndex);
		return editorPickMapper.getAllPick(params);
	}
	

	// 에디터픽 리스트 페이징 처리
	public Paging calculatePagingInfo(int page, int pageSize) {
		int totalCount = editorPickMapper.getEditorPickCount();
		int totalPages = (int) Math.ceil((double) totalCount / pageSize); // 총 페이지 수
	    
	    int pageNum_cnt = 10; // 한번에 보여줄 페이지 수
	    int endPageNum = (int) (Math.ceil((double) page / pageNum_cnt) * pageNum_cnt); // 마지막 페이지 번호
	    int startPageNum = endPageNum - (pageNum_cnt - 1); // 시작 페이지 번호
	    
	    // 마지막 페이지 번호 다시 검증
	    int endPageNum_tmp = (int) (Math.ceil((double) totalCount / pageSize));
	    if (endPageNum > endPageNum_tmp) {
	        endPageNum = endPageNum_tmp;
	    }
	    
	    boolean prev = startPageNum > 1; // 이전 페이지 존재 여부
	    boolean next = endPageNum * pageSize < totalCount; // 다음 페이지 존재 여부
	    
	    Paging paging = new Paging();
	    paging.setTotalPages(totalPages);
	    paging.setStartPageNum(startPageNum);
	    paging.setEndPageNum(endPageNum);
	    paging.setPrev(prev);
	    paging.setNext(next);
		
		return paging;
	}


	// 에디터픽 수정용 내용 갖고오는 로직
	public Map<String, Object> getEditPickByPickIdx(Long pickIdx, EditorPickDto editorPick) throws ParseException {
		Map<String,Object> editPick = new HashMap<>();

		// 에디터픽 idx,postingIdx,filePath등 갖고오기
		editorPick= editorPickMapper.getEditPickByPickIdx(pickIdx);

		Long postingIdx = editorPick.getPostingIdx();
		
		// postingIdx로 해당 공고 갖고오기
		Map<String,Object> postingInfo = editorPickMapper.getPostingByPostingIdx(postingIdx);
		
		// 시간 형식 맞추기 위해 값 꺼내기
	    String startDate = editorPick.getStartDate();
	    String endDate = editorPick.getEndDate();
		
	    // 날짜 형식 변환
	    SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
	    
	    Date startDateParsed = originalFormat.parse(startDate);
	    Date endDateParsed = originalFormat.parse(endDate);
	    
	    String formattedStartDate = targetFormat.format(startDateParsed);
	    String formattedEndDate = targetFormat.format(endDateParsed);
	    
		// 맵에 값 입력
		editPick.put("editorPick", editorPick);
		editPick.put("postingInfo", postingInfo);
		editPick.put("formattedStartDate", formattedStartDate);
		editPick.put("formattedEndDate", formattedEndDate);
		
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

	// 에디터 픽 삭제 로직
	public void editorPickDelete(Long pickIdx) {
			editorPickMapper.editorPickDelete(pickIdx);
	}

	// 에디터 픽 스크랩 리스트 불러오는 로직
	public List<Map<String, Object>> getEditorPickScrap(int pageSize, int startIndex) {
		Map<String, Object> params = new HashMap<>();
		params.put("pageSize", pageSize);
		params.put("startIndex", startIndex);
		return editorPickMapper.getEditorPickScrap(params);
	}

	public Paging calculateEPScrapPagingInfo(int page, int pageSize) {
		int totalCount = editorPickMapper.getEPScrapCount();
		int totalPages = (int) Math.ceil((double) totalCount / pageSize); // 총 페이지 수
	    
	    int pageNum_cnt = 10; // 한번에 보여줄 페이지 수
	    int endPageNum = (int) (Math.ceil((double) page / pageNum_cnt) * pageNum_cnt); // 마지막 페이지 번호
	    int startPageNum = endPageNum - (pageNum_cnt - 1); // 시작 페이지 번호
	    
	    // 마지막 페이지 번호 다시 검증
	    int endPageNum_tmp = (int) (Math.ceil((double) totalCount / pageSize));
	    if (endPageNum > endPageNum_tmp) {
	        endPageNum = endPageNum_tmp;
	    }
	    
	    boolean prev = startPageNum > 1; // 이전 페이지 존재 여부
	    boolean next = endPageNum * pageSize < totalCount; // 다음 페이지 존재 여부
	    
	    Paging paging = new Paging();
	    paging.setTotalPages(totalPages);
	    paging.setStartPageNum(startPageNum);
	    paging.setEndPageNum(endPageNum);
	    paging.setPrev(prev);
	    paging.setNext(next);
		
		return paging;
	}






}

package kh.semi.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class BoardDTO {
	private int textNo; // 숫자 주키 (DB가 만들어 줘)
	private String title;
	private String contents;
	private String writer;
	private Timestamp writedate;
	private int viewCount;
	private String ipAddr;
	
	public BoardDTO() {}
	
	public BoardDTO(int textNo, String title, String contents, String writer, Timestamp writedate, int viewCount) {
		super();
		this.textNo = textNo;
		this.title = title;
		this.contents = contents;
		this.writer = writer;
		this.writedate = writedate;
		this.viewCount = viewCount;
	}
	
	public BoardDTO(int textNo, String title, String contents, String writer, Timestamp writedate, int viewCount,
			String ipAddr) {
		super();
		this.textNo = textNo;
		this.title = title;
		this.contents = contents;
		this.writer = writer;
		this.writedate = writedate;
		this.viewCount = viewCount;
		this.ipAddr = ipAddr;
	}

	public int getTextNo() {
		return textNo;
	}
	public void setTextNo(int textNo) {
		this.textNo = textNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getWritedate() {
		return this.getFormedTime();
	}
	public void setWritedate(Timestamp writedate) {
		this.writedate = writedate;
	}
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public String getIpAddr() {
		return ipAddr;
	}
	public void setIpAddr(String ipAddr) {
		this.ipAddr = ipAddr;
	}
	
	public String getFormedTime() {
		long currentTime = System.currentTimeMillis();
		long writeTime = this.writedate.getTime();
		
		if(currentTime - writeTime <= (1000 * 60)) {
			long time = currentTime - writeTime;
			return time / 1000 + " 초 전";
		}else if((1000 * 60) <= currentTime - writeTime && 
				currentTime - writeTime <= (1000 * 60 * 60)) {
			long time = currentTime - writeTime;
			return time / 1000 / 60 + " 분 전";
		}else if(currentTime - writeTime >= (1000 * 60 * 60) &&
				currentTime - writeTime <= (1000 * 60 * 60 * 24)) {
			long time = currentTime - writeTime;
			return time / 1000 / 60 / 60 + " 시간 전";
		}else {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			return sdf.format(writeTime);
		}
	}
}

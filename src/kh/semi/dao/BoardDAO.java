package kh.semi.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import kh.semi.dto.BoardDTO;
import kh.semi.dto.UfileDTO;


public class BoardDAO {
	static int recordCountPerPage = 10;
	static int naviCountPerPage = 10;
	public static int pageTotalCount;
	
	public Connection getConnection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "kh";
		String pw = "kh";
		return DriverManager.getConnection(url,user,pw);
	}
	
	private PreparedStatement pstatForInsertArticle(Connection con, BoardDTO dto) throws Exception {
		String sql = "insert into Board values(text_num_seq.nextval,?,?,?,default,default,?)";
		PreparedStatement pstat = con.prepareStatement(sql);
		pstat.setString(1, dto.getTitle());
		pstat.setString(2, dto.getContents());
		pstat.setString(3, dto.getWriter());
		pstat.setString(4, dto.getIpAddr());
		return pstat;
	}
	
	public int insertArticle(BoardDTO dto) throws Exception {
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = pstatForInsertArticle(con, dto);
				){
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	private PreparedStatement pstatForInsertImage(Connection con, UfileDTO dto) throws Exception {
		String sql = "insert into imgfile values(imgfile_seq.nextval,?,?,?,?)";
		PreparedStatement pstat = con.prepareStatement(sql);
		pstat.setString(1, dto.getFileName());
		pstat.setString(2, dto.getOriFileName());
		pstat.setString(3, dto.getFilePath());
		pstat.setLong(4, dto.getFileSize());
		return pstat;
	}
	
	public int insertImage(UfileDTO dto) throws Exception {
		try (
				Connection con = this.getConnection();
				PreparedStatement pstat = this.pstatForInsertImage(con, dto);
				){
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public List<BoardDTO> selectAll() throws Exception {
		String sql = "select * from Board";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			List<BoardDTO> result = new ArrayList<>();
			
			while(rs.next()) {
				int textNo = rs.getInt(1);
				String title = rs.getString(2);
				String content = rs.getString(3);
				String writer = rs.getString(4);
				Timestamp writedate = rs.getTimestamp(5);
				int viewCount = rs.getInt(6);
				String ipAddr = rs.getString(7);
				result.add(new BoardDTO(textNo, title, content, writer, writedate, viewCount, ipAddr));
			}
			return result;
		}
	}
	
	private PreparedStatement pstatForSelectByPage(Connection con, int first, int last) throws Exception {
		String sql = "select * from (select row_number() over (order by seq desc) as rown, board.* from board) where rown between ? and ?";
		PreparedStatement pstat = con.prepareStatement(sql);
		pstat.setInt(1, first);
		pstat.setInt(2, last);
		return pstat;
	}
	
	public List<BoardDTO> selectByPage(int currentPage) throws Exception {
		int last = currentPage * recordCountPerPage;
		int first = last - (recordCountPerPage-1);
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = pstatForSelectByPage(con, first, last);
				ResultSet rs = pstat.executeQuery();
				){
			List<BoardDTO> list = new ArrayList<>();
			while(rs.next()) {
				int textNo = rs.getInt(2);
				String title = rs.getString(3);
				String content = rs.getString(4);
				String writer = rs.getString(5);
				Timestamp writedate = rs.getTimestamp(6);
				int viewCount = rs.getInt(7);
				list.add(new BoardDTO(textNo, title, content, writer, writedate, viewCount));
			}
			return list;
		}
	}
	
	public List<BoardDTO> selectByKeyword(String option, String keyword) throws Exception {
		String tmp = "";
		if(option.equals("제목")) {
			tmp = "title";
		}else if(option.equals("내용")) {
			tmp = "contents";
		}else if(option.equals("작성자")) {
			tmp = "writer";
		}
		String sql = "select row_number() over (order by seq desc) as rown, board.* from Board"
				+ " where "+ tmp +" like '%"+keyword+"%'";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			List<BoardDTO> result = new ArrayList<>();
			while(rs.next()) {
				int textNo = rs.getInt(2);
				String title = rs.getString(3);
				String content = rs.getString(4);
				String writer = rs.getString(5);
				Timestamp writedate = rs.getTimestamp(6);
				int viewCount = rs.getInt(7);
				result.add(new BoardDTO(textNo, title, content, writer, writedate, viewCount));
			}
			return result;
		}
	}
	
	public List<BoardDTO> getSubList(int currentPage, List<BoardDTO> list, int countArticle) throws Exception {
		int last = currentPage * recordCountPerPage;
		int first = last - (recordCountPerPage);
		if(last > countArticle) {
			last = countArticle;
		}
		return list.subList(first, last);
	}
	
	public List<String> getNaviForKeywordSearch(int currentPage, int countArticle) throws Exception {
		int recordTotalCount = countArticle;
		
		// 가지고 있는 게시글의 수에 맞는 페이지의 개수를 구한다.
		if(recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / recordCountPerPage + 1;
		}else {
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}
		
		// 현재 페이지 오류 검출 및 정정
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		
		int startNavi = (currentPage - 1) / naviCountPerPage * naviCountPerPage + 1;
		int endNavi = startNavi + (naviCountPerPage - 1);
		
		// 네비 끝값이 최대 페이지 번호를 넘어가면 최대 페이지 번호로 네비 끝값을 설정해준다.
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		
		Boolean needPrev = true;
		Boolean needNext = true;
		
		if(startNavi == 1) {
			needPrev = false;
		}
		if(endNavi == pageTotalCount) {
			needNext = false;
		}
		
		List<String> list = new ArrayList<>();
		if(needPrev) {
			list.add(0+"");
		}else {
			list.add(-1+"");
		}
		for(int i = startNavi; i <= endNavi; i++) {
			list.add(i+"");
		}
		if(needNext) {
			list.add(0+"");
		}else {
			list.add(-1+"");
		}
		return list;
	}
	
	private PreparedStatement pstatForArticle(Connection con, int textNo) throws Exception {
		String sql = "select * from Board where seq=?";
		PreparedStatement pstat = con.prepareStatement(sql);
		pstat.setInt(1, textNo);
		return pstat;
	}
	
	public BoardDTO showArticle(int textNo) throws Exception {
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = pstatForArticle(con, textNo);
				ResultSet rs = pstat.executeQuery();
				){
			BoardDTO dto = new BoardDTO();			
			if(rs.next()) {
				int no = rs.getInt(1);
				dto.setTextNo(no);
				dto.setTitle(rs.getString(2));
				dto.setContents(rs.getString(3));
				dto.setWriter(rs.getString(4));
				dto.setWritedate(rs.getTimestamp(5));
				int view = rs.getInt(6) + 1;
				dto.setViewCount(view);
				this.viewCountUp(view, no);
			}
			return dto;
		}
	}
	
	public void viewCountUp(int view, int no) throws Exception {
		String sql = "update Board set viewcount=? where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, view);
			pstat.setInt(2, no);
			pstat.executeUpdate();	
			con.commit();
		}
	}
	
	public int editArticle(int textNo, String title, String content) throws Exception {
		String sql = "update Board set title=?, contents=? where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1, title);
			pstat.setString(2, content);
			pstat.setInt(3, textNo);
			int result = pstat.executeUpdate();	
			con.commit();
			return result;
		}
	}
	
	public int deleteArticle(int textNo) throws Exception {
		String sql = "delete from Board where seq=?";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setInt(1, textNo);
			int result = pstat.executeUpdate();	
			con.commit();
			return result;
		}
	}
	
	public int recordTotalCount() throws Exception {
		String sql = "select count(*) from Board";
		Connection con = this.getConnection();
		PreparedStatement pstat = con.prepareStatement(sql);
		ResultSet rs = pstat.executeQuery();
		int result = 0;
		if(rs.next()) {
			result = rs.getInt(1);
		}
		return result;
	}
	
	public List<String> getNavi(int currentPage) throws Exception {
		int recordTotalCount = this.recordTotalCount();
		
		// 가지고 있는 게시글의 수에 맞는 페이지의 개수를 구한다.
		if(recordTotalCount % recordCountPerPage > 0) {
			pageTotalCount = recordTotalCount / recordCountPerPage + 1;
		}else {
			pageTotalCount = recordTotalCount / recordCountPerPage;
		}
		
		// 현재 페이지 오류 검출 및 정정
		if(currentPage < 1) {
			currentPage = 1;
		}else if(currentPage > pageTotalCount) {
			currentPage = pageTotalCount;
		}
		
		int startNavi = (currentPage - 1) / naviCountPerPage * naviCountPerPage + 1;
		int endNavi = startNavi + (naviCountPerPage - 1);
		
		// 네비 끝값이 최대 페이지 번호를 넘어가면 최대 페이지 번호로 네비 끝값을 설정해준다.
		if(endNavi > pageTotalCount) {
			endNavi = pageTotalCount;
		}
		
		Boolean needPrev = true;
		Boolean needNext = true;
		
		if(startNavi == 1) {
			needPrev = false;
		}
		if(endNavi == pageTotalCount) {
			needNext = false;
		}
		
		List<String> list = new ArrayList<>();
		if(needPrev) {
			list.add(0+"");
		}else {
			list.add(-1+"");
		}
		
		for(int i = startNavi; i <= endNavi; i++) {
			list.add(i+"");
		}
		if(needNext) {
			list.add(0+"");
		}else {
			list.add(-1+"");
		}
		return list;
	}
}

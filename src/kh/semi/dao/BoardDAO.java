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
		String url = "jdbc:oracle:thin:@192.168.60.23:1521:xe";
		String user = "semi";
		String pw = "semi";
		return DriverManager.getConnection(url,user,pw);
	}


	public int insertBoard(BoardDTO dto)throws Exception{
		String sql = "insert into Board values(b_no_seq.nextval,?,?,?,?,?,?,?,?,?,default,default,default,default)";
		try(
				Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				){
			pstat.setString(1,dto.getTitle());
			pstat.setString(2,dto.getWriter());
			pstat.setInt(3,dto.getAmount());
			pstat.setString(4,dto.getBank());
			pstat.setString(5,dto.getAccount());
			if(dto.getContents().length()<=4000) {
				pstat.setString(6,dto.getContents());
			}else if(dto.getContents().length() > 4000 && dto.getContents().length()<=8000){
				pstat.setString(6,dto.getContents().substring(0, 3999));
				pstat.setString(7,dto.getContents().substring(4000,7999));
			}else if(dto.getContents().length() > 8000 && dto.getContents().length() <=11999) {
				pstat.setString(6,dto.getContents().substring(0, 3999));
				pstat.setString(7,dto.getContents().substring(4000,7999));
				pstat.setString(8,dto.getContents().substring(8000, 11999));
			}
			pstat.setString(9, dto.getDueDate());
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}

	}
}


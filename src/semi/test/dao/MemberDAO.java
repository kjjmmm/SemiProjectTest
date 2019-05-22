package semi.test.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import semi.test.dto.MemberDTO;


public class MemberDAO {
	public Connection getConntection() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@192.168.60.8:1521:xe";
		String user = "kh";
		String pw = "kh";
		return DriverManager.getConnection(url, user, pw);
	}
	
	private PreparedStatement pstatForInsertMember(Connection con, MemberDTO dto) throws Exception {
		String sql = "insert into members values (?,?,?,?,?,?,?,?,default,?,?)";
		PreparedStatement pstat = con.prepareStatement(sql);
		pstat.setString(1, dto.getEmail());
		pstat.setString(2, dto.getPw());
		pstat.setString(3, dto.getName());
		pstat.setString(4, dto.getNickname());
		pstat.setString(5, dto.getPhone());
		pstat.setString(6, dto.getZipCode());
		pstat.setString(7, dto.getAddress1());
		pstat.setString(8, dto.getAddress2());
		pstat.setString(9, dto.getIpAddress());
		pstat.setString(10, dto.getAdmin());
		return pstat;
	}
	
	public int insertMember(MemberDTO dto) throws Exception {
		try(
				Connection con = this.getConntection();
				PreparedStatement pstat = this.pstatForInsertMember(con, dto);
				){
			int result = pstat.executeUpdate();
			con.commit();
			return result;
		}
	}
	
	public List<MemberDTO> selectAll() throws Exception {
		String sql = "select * from members";
		List<MemberDTO> result = new ArrayList<>();
		try(
				Connection con = this.getConntection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();
				){
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setEmail(rs.getString(1));
				dto.setPw(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setNickname(rs.getString(4));
				dto.setPhone(rs.getString(5));
				dto.setZipCode(rs.getString(6));
				dto.setAddress1(rs.getString(7));
				dto.setAddress2(rs.getString(8));
				dto.setJoinDate(rs.getTimestamp(9));
				dto.setIpAddress(rs.getString(10));
				dto.setAdmin(rs.getString(11));
				result.add(dto);
			}
			return result;
		}
	}
}

package cinema;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;

	public UserDAO(Connection conn) {
		this.conn = conn;
	}

	public int insertData(UserDTO dto) {

		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "insert into userTable (userId,userPw,userName,";
			sql += "userJumin,userTelecom,userTel,userEmail,sample4_postcode,sample4_roadAddress,sample4_jibunAddress,sample4_detailAddress,sample4_extraAddress) ";
			sql += "values (?,?,?,?,?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getUserId());
			pstmt.setString(2, dto.getUserPw());
			pstmt.setString(3, dto.getUserName());
			pstmt.setString(4, dto.getUserJumin());
			pstmt.setString(5, dto.getUserTelecom());
			pstmt.setString(6, dto.getUserTel());
			pstmt.setString(7, dto.getUserEmail());
			pstmt.setString(8, dto.getSample4_postcode());
			pstmt.setString(9, dto.getSample4_roadAddress());
			pstmt.setString(10, dto.getSample4_jibunAddress());
			pstmt.setString(11, dto.getSample4_detailAddress());
			pstmt.setString(12, dto.getSample4_extraAddress());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

	public UserDTO getReadData(String userId) {

		UserDTO dto = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select userId, userPw, userName, ";
			sql += "userJumin, userTelecom, userTel, userEmail,sample4_postcode,sample4_roadAddress,sample4_jibunAddress,sample4_detailAddress,sample4_extraAddress ";
			sql += "from userTable where userId = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dto = new UserDTO();

				dto.setUserId(rs.getString("userId"));
				dto.setUserPw(rs.getString("userPw"));
				dto.setUserName(rs.getString("userName"));
				dto.setUserJumin(rs.getString("userJumin"));
				dto.setUserTelecom(rs.getString("userTelecom"));
				dto.setUserTel(rs.getString("userTel"));
				dto.setUserEmail(rs.getString("userEmail"));
				dto.setSample4_postcode(rs.getString("sample4_postcode"));
				dto.setSample4_roadAddress(rs.getString("sample4_roadAddress"));
				dto.setSample4_jibunAddress(rs.getString("sample4_jibunAddress"));
				dto.setSample4_detailAddress(rs.getString("sample4_detailAddress"));
				dto.setSample4_extraAddress(rs.getString("sample4_extraAddress"));
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;

	}

	public int updateData(String userId, String newPw) {
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "update usertable set userPw=? ";
			sql += "WHERE userId=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, newPw);
			pstmt.setString(2, userId);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

}

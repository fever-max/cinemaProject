package cinema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MovieComentDAO {

	private Connection conn;

	public MovieComentDAO(Connection conn) {
		this.conn = conn;
	}

	// ¸®ºä °¹¼ö
	public int getDataCount(int movieNo) {

		int dataCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(count(*),0) from movieComentTable where movieNo= ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, movieNo);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dataCount = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {

			System.out.println(e.toString());
		}

		return dataCount;

	}

	// ¸®ºä ¸ðµç Á¤º¸
	public List<MovieComentDTO> getListsReview(int start, int end, int movieNo) {
		List<MovieComentDTO> lists = new ArrayList<MovieComentDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select * from (";
			sql += "select rownum rnum,data.* from (";
			sql += "select comentNo,name,comentContent,";
			sql += "comentCreated,movieno from movieComentTable where movieNo=? order by comentNo desc) data) ";
			sql += "where rnum>=? and rnum<=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, movieNo);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				MovieComentDTO dto = new MovieComentDTO();

				dto.setComentNo(rs.getInt("comentNo"));
				dto.setName(rs.getString("name"));
				dto.setComentContent(rs.getString("comentContent"));
				dto.setComentCreated(rs.getString("comentCreated"));
				dto.setMovieNo(rs.getInt("movieNo"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;
	}

	// ÄÚ¸àÆ® »èÁ¦
	public int redeleteData(int comentNo) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "delete from movieComentTable where comentNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, comentNo);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());

		}

		return result;

	}

	public int getMaxNumReview() {

		int maxNum = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(max(comentNo),0) from movieComentTable";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				maxNum = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return maxNum;
	}

	// ¸®ºä µî·Ï
	public int insertReview(MovieComentDTO reviewdto) {
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "insert into movieComentTable (comentNo,name,comentContent, ";
			sql += "comentCreated, movieNo) values (?,?,?,sysdate,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, reviewdto.getComentNo());
			pstmt.setString(2, reviewdto.getName());
			pstmt.setString(3, reviewdto.getComentContent());
			pstmt.setInt(4, reviewdto.getMovieNo());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;

	}

}

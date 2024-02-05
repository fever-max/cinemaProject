package cinema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {

	private Connection conn;

	public MovieDAO(Connection conn) {
		this.conn = conn;
	}

	// 영화 전체 출력 메서드

	public List<MovieDTO> getMovieLists() {

		List<MovieDTO> lists = new ArrayList<MovieDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select * from movieTable ORDER BY moiveScore DESC";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// 데이터 저장
				MovieDTO dto = new MovieDTO();

				dto.setMovieNo(rs.getInt("movieNo"));
				dto.setMovieName(rs.getString("movieName"));
				dto.setMovieGenre(rs.getString("movieGenre"));
				dto.setMovieContent(rs.getString("movieContent"));
				dto.setMovieDirector(rs.getString("movieDirector"));
				dto.setMovieDate(rs.getString("movieDate"));
				dto.setMovieTime(rs.getString("movieTime"));
				dto.setMoiveActor(rs.getString("moiveActor"));
				dto.setMoiveAge(rs.getString("moiveAge"));
				dto.setMoiveAge2(rs.getString("moiveAge2"));
				dto.setMoiveImage(rs.getString("moiveImage"));
				dto.setMoiveScore(rs.getInt("moiveScore"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;

	}

	// 영화 이미지
	public MovieDTO getImage(String movieName) {

		MovieDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select moiveImage from movieTable where movieName=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, movieName);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new MovieDTO();

				dto.setMoiveImage(rs.getString("moiveImage"));
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}

	// 영화 한개 출력 메서드
	public MovieDTO getReadData(int movieNo) {

		MovieDTO dto = null;

		PreparedStatement pstmt = null;

		ResultSet rs = null;

		String sql;

		try {

			sql = "select movieno,movieName,movieGenre,movieContent,movieDirector,movieDate, ";
			sql += "movieTime,moiveActor,moiveAge,moiveScore,moiveImage,moiveAge2 from movietable where movieno=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, movieNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				dto = new MovieDTO();

				dto.setMovieNo(rs.getInt("movieno"));
				dto.setMovieName(rs.getString("MovieName"));
				dto.setMovieGenre(rs.getString("movieGenre"));
				dto.setMovieContent(rs.getString("movieContent"));
				dto.setMovieDirector(rs.getString("movieDirector"));
				dto.setMovieDate(rs.getString("movieDate"));
				dto.setMovieTime(rs.getString("movieTime"));
				dto.setMoiveActor(rs.getString("moiveActor"));
				dto.setMoiveAge(rs.getString("moiveAge"));
				dto.setMoiveScore(rs.getInt("moiveScore"));
				dto.setMoiveImage(rs.getString("moiveImage"));
				dto.setMoiveAge2(rs.getString("moiveAge2"));

			}

			pstmt.close();
			rs.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;

	}

}

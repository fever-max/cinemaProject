package cinema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TheaterDAO {

	private Connection conn;

	public TheaterDAO(Connection conn) {
		this.conn = conn;
	}

	// 선택 영화 > 극장 정보 메서드
	public List<TheaterDTO> getTheaters(int movieNo) {

		List<TheaterDTO> lists = new ArrayList<TheaterDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select DISTINCT theaterLocal from theatersTable where movieNo = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, movieNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				TheaterDTO dto = new TheaterDTO();

				dto.setTheaterLocal(rs.getString("theaterLocal"));

				lists.add(dto);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;
	}

	// 선택 극장 > 상영 정보 메서드
	public List<TheaterDTO> getDate(String movieName, String theaterLocal) {

		List<TheaterDTO> lists = new ArrayList<TheaterDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select DISTINCT theaterDay from theatersTable where theaterLocal = ? and movieName = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, theaterLocal);
			pstmt.setString(2, movieName);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				TheaterDTO dto = new TheaterDTO();

				dto.setTheaterDay(rs.getString("theaterDay"));

				lists.add(dto);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;
	}

	// 선택 극장 > 상영 정보 메서드
	public List<TheaterDTO> getTime(String movieName, String theaterLocal, String theaterDay) {

		List<TheaterDTO> lists = new ArrayList<TheaterDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select DISTINCT theaterTime from theatersTable where theaterLocal = ? and movieName = ? and theaterDay = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, theaterLocal);
			pstmt.setString(2, movieName);
			pstmt.setString(3, theaterDay);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				TheaterDTO dto = new TheaterDTO();

				dto.setTheaterTime(rs.getString("theaterTime"));

				lists.add(dto);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;
	}

	// 영화, 극장, 날짜, 시간이 선택된 1개의 정보
	public TheaterDTO getCk(String movieName, String theaterLocal, String theaterDay, String theaterTime) {

		TheaterDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select * from theatersTable where theaterLocal = ? and movieName = ? and theaterDay = ? and theaterTime = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, theaterLocal);
			pstmt.setString(2, movieName);
			pstmt.setString(3, theaterDay);
			pstmt.setString(4, theaterTime);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dto = new TheaterDTO();

				dto.setTheaterNo(rs.getInt("theaterNo"));
				dto.setMovieNo(rs.getInt("movieNo"));
				dto.setMovieName(rs.getString("movieName"));
				dto.setTheaterLocal(rs.getString("theaterLocal"));
				dto.setTheaterDay(rs.getString("theaterDay"));
				dto.setTheaterTime(rs.getString("theaterTime"));
				dto.setTheaterFullSeats(rs.getInt("theaterFullSeats"));
				dto.setTheaterNowSeats(rs.getInt("theaterNowSeats"));
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	// 상영정보 업데이트
	public int updateSeat(BookingDTO bookingDTO) {
		PreparedStatement pstmt = null;
		int result = 0;

		String getTheaterDay = bookingDTO.getTheaterDay();
		String getTheaterTime = bookingDTO.getTheaterTime();

		try {
			String sql = "UPDATE theatersTable SET theaterNowSeats = theaterNowSeats - ? ";
			sql += "WHERE theaterNo=? ";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, bookingDTO.getTheaterPerson());
			pstmt.setInt(2, bookingDTO.getTheaterNo());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	// 전체 상영관 출력
	public List<TheaterDTO> getTheater() {

		List<TheaterDTO> lists = new ArrayList<TheaterDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select DISTINCT theaterLocal from theatersTable";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				TheaterDTO dto = new TheaterDTO();

				dto.setTheaterLocal(rs.getString("theaterLocal"));

				lists.add(dto);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;

	}

	// 영화 지역 전체 출력
	public List<TheaterDTO> localTheaters(String theaterLocal) {

		List<TheaterDTO> lists = new ArrayList<TheaterDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select * from theatersTable where theaterLocal = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, theaterLocal);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				TheaterDTO dto = new TheaterDTO();

				dto.setTheaterNo(rs.getInt("theaterNo"));
				dto.setMovieNo(rs.getInt("movieNo"));
				dto.setMovieName(rs.getString("movieName"));
				dto.setTheaterLocal(rs.getString("theaterLocal"));
				dto.setTheaterDay(rs.getString("theaterDay"));
				dto.setTheaterTime(rs.getString("theaterTime"));
				dto.setTheaterFullSeats(rs.getInt("theaterFullSeats"));
				dto.setTheaterNowSeats(rs.getInt("theaterNowSeats"));

				lists.add(dto);

			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;
	}

	public int getTotalMovie(String theaterLocal) {
		int total = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select count(*) from theatersTable where theaterLocal=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, theaterLocal);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				total = rs.getInt(1);
			}
			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return total;

	}

	// 예매 취소시 영화관 현재좌석 증가
	public int deleteMovie(int theaterNo, int theaterPerson) {

		int result = 0;
		PreparedStatement pstmt = null;

		try {
			String sql = "UPDATE theatersTable SET theaterNowSeats = theaterNowSeats + ? ";
			sql += "WHERE theaterNo= ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, theaterPerson);
			pstmt.setInt(2, theaterNo);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

}

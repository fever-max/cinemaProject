package cinema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import oracle.net.aso.p;

public class BookingDAO {

	private Connection conn;

	public BookingDAO(Connection conn) {
		this.conn = conn;
	}

	// 부킹 넘버 카운팅
	public int getMaxNo() {
		int getNo = 0;

		PreparedStatement ptsmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select nvl(max(bookingNo), 0) from bookingTable";
			ptsmt = conn.prepareStatement(sql);

			rs = ptsmt.executeQuery();

			if (rs.next()) {
				// 첫번째 칼럼 갯수
				getNo = rs.getInt(1);
			}

			rs.close();
			ptsmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return getNo;
	}

	// 예매 인서트
	public int insertBooking(BookingDTO bookingDTO) {
		PreparedStatement pstms = null;
		String sql;
		int result = 0;

		try {
			sql = "insert into bookingTable (bookingNo, userId, movieName, movieImg, theaterNo, theaterLocal, theaterDay, theaterTime, theaterPerson, theaterTicket, ticketPrice) ";
			sql += "values(?,?,?,?,?,?,?,?,?,?,?)";

			pstms = conn.prepareStatement(sql);

			pstms.setLong(1, bookingDTO.getBookingNo());
			pstms.setString(2, bookingDTO.getUserId());
			pstms.setString(3, bookingDTO.getMovieName());
			pstms.setString(4, bookingDTO.getMovieImg());
			pstms.setInt(5, bookingDTO.getTheaterNo());
			pstms.setString(6, bookingDTO.getTheaterLocal());
			pstms.setString(7, bookingDTO.getTheaterDay());
			pstms.setString(8, bookingDTO.getTheaterTime());
			pstms.setInt(9, bookingDTO.getTheaterPerson());
			pstms.setString(10, bookingDTO.getTheaterTicket());
			pstms.setInt(11, bookingDTO.getTicketPrice());

			result = pstms.executeUpdate();

			pstms.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;
	}

	// 예매된 좌석 찾는 메서드
	public List<BookingDTO> getTheaters(String movieName, String theaterLocal, String theaterDay, String theaterTime) {

		List<BookingDTO> lists = new ArrayList<BookingDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select * from bookingTable where movieName=? and theaterLocal=? ";
			sql += "and TO_DATE(theaterDay, 'YYYY-MM-DD') = TO_DATE(?, 'YYYY-MM-DD') and theaterTime=?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, movieName);
			pstmt.setString(2, theaterLocal);
			pstmt.setString(3, theaterDay);
			pstmt.setString(4, theaterTime);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BookingDTO dto = new BookingDTO();

				dto.setTheaterTicket(rs.getString("theaterTicket"));

				lists.add(dto);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return lists;
	}

	// 예매 내역
	public List<BookingDTO> getReadData(String userId) {

		List<BookingDTO> lists = new ArrayList<BookingDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select * from bookingTable where userId = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, userId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				BookingDTO dto = new BookingDTO();

				dto.setBookingNo(rs.getLong("bookingNo"));
				dto.setUserId(rs.getString("userId"));
				dto.setMovieName(rs.getString("movieName"));
				dto.setMovieImg(rs.getString("movieImg"));
				dto.setTheaterNo(rs.getInt("theaterNo"));
				dto.setTheaterLocal(rs.getString("theaterLocal"));
				dto.setTheaterDay(rs.getString("theaterDay"));
				dto.setTheaterTime(rs.getString("theaterTime"));
				dto.setMovieName(rs.getString("movieName"));
				dto.setTheaterPerson(rs.getInt("theaterPerson"));
				dto.setTheaterTicket(rs.getString("theaterTicket"));
				dto.setTicketPrice(rs.getInt("ticketPrice"));

				lists.add(dto);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return lists;
	}

	// 영화 삭제
	public int deleteMovie(Long bookingNo, String userId) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "delete from bookingTable where bookingNo=? and userId=?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, bookingNo);
			pstmt.setString(2, userId);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return result;

	}

}

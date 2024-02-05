package cinema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

	
	private Connection conn;

	public OrderDAO(Connection conn) {
		this.conn = conn;

	}
	
	
	public int getMaxNo() {

		int maxNo = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(max(orderNo),0) from OrderTable";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				maxNo = rs.getInt(1);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return maxNo;
	}
	
	// 구매 내역 제품 테이블 입력
		public int insertOrder(OrderDTO dto) {

			int result = 0;

			PreparedStatement pstmt = null;
			String sql;

			try {

				sql = "INSERT INTO orderTable (orderNo, userId, productName, productPrice, productCount, orderTotal, orderDate) ";
				sql += "VALUES (?, ?, ?, ?, ?, ?, sysdate)";

				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, dto.getOrderNo());
				pstmt.setString(2, dto.getUserId());
				pstmt.setString(3, dto.getProductName());
				pstmt.setInt(4, dto.getProductPrice());
				pstmt.setInt(5, dto.getProductCount());
				pstmt.setInt(6, dto.getOrderTotal());

				result = pstmt.executeUpdate();

				pstmt.close();

			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return result;
		}

	
	
		public List<OrderDTO> getLists(String searchKey, String searchValue) {

			List<OrderDTO> lists = new ArrayList<>();

			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;

			try {

				searchValue = "%" + searchValue + "%";

				sql = "SELECT * FROM (SELECT ROWNUM rnum, data.* FROM (SELECT orderNo, userId, productName, productPrice, productCount, orderTotal, orderDate ";
				sql += "FROM orderTable WHERE " + searchKey + " LIKE ? ";
				sql += "ORDER BY orderNo DESC) data) WHERE rnum >= ? AND rnum <= ?";

				pstmt = conn.prepareStatement(sql);

				pstmt.setString(1, searchValue);
			

				rs = pstmt.executeQuery();

				while (rs.next()) {
					OrderDTO dto = new OrderDTO();

					dto.setOrderNo(rs.getInt("orderNo"));
					dto.setUserId(rs.getString("userId"));
					dto.setProductName(rs.getString("productName"));
					dto.setProductPrice(rs.getInt("productPrice"));
					dto.setProductCount(rs.getInt("productCount"));
					dto.setOrderTotal(rs.getInt("orderTotal"));
					dto.setOrderDate(rs.getString("orderDate"));

					lists.add(dto);
				}

				rs.close();
				pstmt.close();

			} catch (Exception e) {
				System.out.println(e.toString());
			}

			return lists;
		}
		
		
		
		
		   // 장바구니 테이블에 제품 추가
	    public int addCart(OrderDTO dto) {
	        int result = 0;

	        PreparedStatement pstmt = null;
	        String sql;

	        try {
	            sql = "INSERT INTO OrderTable (userId, productName, productPrice, productCount, orderTotal, orderDate) ";
	            sql += "VALUES (?, ?, ?, ?, ?, sysdate)";

	            pstmt = conn.prepareStatement(sql);

	            pstmt.setString(1, dto.getUserId());
	            pstmt.setString(2, dto.getProductName());
	            pstmt.setInt(3, dto.getProductPrice());
	            pstmt.setInt(4, dto.getProductCount());
	            pstmt.setInt(5, dto.getOrderTotal());

	            result = pstmt.executeUpdate();

	            pstmt.close();
	        } catch (Exception e) {
	            System.out.println(e.toString());
	        }

	        return result;
	    }
	    
	    // 장바구니에서 제품 삭제
	    public int removeCart(String userId, String productName) {
	        int result = 0;

	        PreparedStatement pstmt = null;
	        String sql;

	        try {
	            sql = "DELETE FROM OrderTable WHERE userId = ? AND productName = ?";

	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, userId);
	            pstmt.setString(2, productName);

	            result = pstmt.executeUpdate();

	            pstmt.close();
	        } catch (Exception e) {
	            System.out.println(e.toString());
	        }

	        return result;
	    }

}

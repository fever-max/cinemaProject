package cinema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class StoreDAO {

	private Connection conn;

	public StoreDAO(Connection conn) {
		this.conn = conn;

	}

	// 상품번호 최대값구하기
	public int getMaxNo() {
		int maxNo = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT NVL(MAX(productNo), 0) FROM StoreTable";
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

	// 데이터갯수
	public int getDataCount() {

		int dataCount = 0;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select nvl(count(*),0) from StoreTable";
			pstmt = conn.prepareStatement(sql);

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

	// 스토어 제품 테이블 입력
	public int insertData(StoreDTO dto) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {
			sql = "INSERT INTO StoreTable (productNo, productName, productPrice, productContent, saveFileName, originalFileName) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getProductNo());
			pstmt.setString(2, dto.getProductName());
			pstmt.setInt(3, dto.getProductPrice());
			pstmt.setString(4, dto.getProductContent());
			pstmt.setString(5, dto.getSaveFileName());
			pstmt.setString(6, dto.getOriginalFileName());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	// 스토어 제품 검색 및 리스트 가져오기 필요시 주석해제
	/*
	 * public List<StoreDTO> getLists(String searchKey, String searchValue) {
	 * List<StoreDTO> lists = new ArrayList<>();
	 * 
	 * PreparedStatement pstmt = null; ResultSet rs = null; String sql;
	 * 
	 * try { searchValue = "%" + searchValue + "%"; sql =
	 * "SELECT * FROM (SELECT ROWNUM rnum, data.* FROM (SELECT productNo, productName, productPrice, productCount, productContent "
	 * ; sql += "FROM StoreTable WHERE " + searchKey +
	 * " LIKE ? ORDER BY productNo DESC) data) WHERE rnum >= ? AND rnum <= ?";
	 * 
	 * pstmt = conn.prepareStatement(sql); pstmt.setString(1, searchValue);
	 * 
	 * rs = pstmt.executeQuery();
	 * 
	 * while (rs.next()) { StoreDTO dto = new StoreDTO();
	 * dto.setProductNo(rs.getInt("productNo"));
	 * dto.setProductName(rs.getString("productName"));
	 * dto.setProductPrice(rs.getInt("productPrice"));
	 * dto.setProductCount(rs.getInt("productCount"));
	 * dto.setProductContent(rs.getString("productContent")); lists.add(dto); }
	 * 
	 * } catch (Exception e) { System.out.println(e.toString()); }
	 * 
	 * return lists; }
	 */

	public List<StoreDTO> getList(int start, int end) {
		List<StoreDTO> lists = new ArrayList<StoreDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select productNo, productName, productPrice, productCount, productContent, saveFileName, originalFileName from StoreTable  WHERE productNo <10 order by productNo desc) data) ";
			sql += "where rnum >= ? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				StoreDTO dto = new StoreDTO();
				dto.setProductNo(rs.getInt("productNo"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductCount(rs.getInt("productCount"));
				dto.setProductContent(rs.getString("productContent"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				lists.add(dto);
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lists;
	}

	// productNo 10번부터 20번까지 상품리스트(10~20번은 카드)
	public List<StoreDTO> getList(int start, int end, int a) {
		List<StoreDTO> lists = new ArrayList<StoreDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select productNo, productName, productPrice, productCount, productContent, saveFileName, originalFileName from StoreTable  WHERE productNo >= 10 AND productNo <20 order by productNo desc) data) ";
			sql += "where rnum >= ? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				StoreDTO dto = new StoreDTO();
				dto.setProductNo(rs.getInt("productNo"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductCount(rs.getInt("productCount"));
				dto.setProductContent(rs.getString("productContent"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				lists.add(dto);
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lists;
	}

	// 1번부터 10번까지 상품리스트(1~10번은 먹을거)
	public List<StoreDTO> getList(int start, int end, String a) {
		List<StoreDTO> lists = new ArrayList<StoreDTO>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select * from (";
			sql += "select rownum rnum, data.* from (";
			sql += "select productNo, productName, productPrice, productCount, productContent, saveFileName, originalFileName from StoreTable  WHERE productNo >= 1 AND productNo <10  order by productNo desc) data) ";
			sql += "where rnum >= ? and rnum <= ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				StoreDTO dto = new StoreDTO();
				dto.setProductNo(rs.getInt("productNo"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductCount(rs.getInt("productCount"));
				dto.setProductContent(rs.getString("productContent"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				lists.add(dto);
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lists;
	}

	public List<StoreDTO> getList() {
		List<StoreDTO> lists = new ArrayList<>();

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "SELECT * FROM StoreTable";

			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				StoreDTO dto = new StoreDTO();
				dto.setProductNo(rs.getInt("productNo"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductCount(rs.getInt("productCount"));
				dto.setProductContent(rs.getString("productContent"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
				lists.add(dto);
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return lists;
	}

	// 상품Id으로 상품정보 들고오기
	public StoreDTO getReadProduct(int productId) {

		StoreDTO dto = null;

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {

			sql = "select productNo,productName,productPrice,productCount,productContent ";
			sql += "from StoreTable where productId=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, productId);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				dto = new StoreDTO();

				dto.setProductNo(rs.getInt("productNo"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductCount(rs.getInt("productCount"));
				dto.setProductContent(rs.getString("productContent"));
			}

			rs.close();
			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return dto;
	}

	// 스토어 제품 갯수 추가
	public int updateData(StoreDTO dto) {
		int result = 0;

		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "update StoreTable set productCount=? where productNo=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dto.getProductCount());
			pstmt.setInt(2, dto.getProductNo());

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	// 상품삭제
	public int deleteData(int productNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql;

		try {

			sql = "delete from StoreTable where productNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productNo);

			result = pstmt.executeUpdate();

			pstmt.close();

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return result;
	}

	// 상품번호로 불러오기
	public StoreDTO getReadData(int productNo) {
		StoreDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;

		try {
			sql = "select productNo, productName, productPrice, productCount, productContent, saveFileName, originalFileName ";
			sql += "from StoreTable where productNo=?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, productNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto = new StoreDTO();
				dto.setProductNo(rs.getInt("productNo"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductCount(rs.getInt("productCount"));
				dto.setProductContent(rs.getString("productContent"));
				dto.setSaveFileName(rs.getString("saveFileName"));
				dto.setOriginalFileName(rs.getString("originalFileName"));
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return dto;
	}

	// 장바구니(세션)에 담는기능
	public void addCart(HttpSession session, int productNo, int productCount) {
		try {
			// 기존에 저장된 장바구니 정보 가져오기
			List<StoreDTO> cart = (List<StoreDTO>) session.getAttribute("cart");

			if (cart == null) {
				// 세션에 장바구니 정보가 없으면 새로운 리스트 생성
				cart = new ArrayList<>();
				session.setAttribute("cart", cart);
			}

			// 상품번호로 해당 제품 정보 가져오기
			StoreDTO dto = getReadData(productNo);
			dto.setProductCount(productCount);
			dto.setProductPrice(dto.getProductPrice() * dto.getProductCount());

			if (dto != null) {
				// 장바구니에 상품 추가
				cart.add(dto);
			} else {
				System.out.println("상품이 존재하지 않습니다. ");
			}
		} catch (Exception e) {
			System.out.println("장바구니 추가 중 오류 발생: " + e.toString());
		}
	}

	// 세션장바구니에서 상품제거
	public void removeCart(HttpSession session, int productNo) {
		try {
			// 세션에서 장바구니 정보 가져오기
			List<StoreDTO> cart = (List<StoreDTO>) session.getAttribute("cart");

			if (cart != null) {
				// 상품번호로 해당 상품 찾기
				for (StoreDTO dto : cart) {
					if (dto.getProductNo() == productNo) {
						// 상품 삭제
						cart.remove(dto);
						break;
					}
				}
			}
		} catch (Exception e) {
			System.out.println("장바구니 상품 삭제 중 오류 발생: " + e.toString());
		}
	}

	// 장바구니 세션리스트 들고오기
	public List<StoreDTO> getCartList(HttpSession session) {
		List<StoreDTO> cartList = null;

		try {
			// 세션에서 장바구니 정보 가져오기
			cartList = (List<StoreDTO>) session.getAttribute("cart");

			if (cartList == null) {
				// 장바구니가 비어있을 경우, 새로운 리스트 생성
				cartList = new ArrayList<>();
			}
		} catch (Exception e) {
			System.out.println("장바구니 목록 조회 중 오류 발생: " + e.toString());
		}

		return cartList;
	}

}

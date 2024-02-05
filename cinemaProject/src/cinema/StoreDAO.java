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

	// ��ǰ��ȣ �ִ밪���ϱ�
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

	// �����Ͱ���
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

	// ����� ��ǰ ���̺� �Է�
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

	// ����� ��ǰ �˻� �� ����Ʈ �������� �ʿ�� �ּ�����
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

	// productNo 10������ 20������ ��ǰ����Ʈ(10~20���� ī��)
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

	// 1������ 10������ ��ǰ����Ʈ(1~10���� ������)
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

	// ��ǰId���� ��ǰ���� ������
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

	// ����� ��ǰ ���� �߰�
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

	// ��ǰ����
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

	// ��ǰ��ȣ�� �ҷ�����
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

	// ��ٱ���(����)�� ��±��
	public void addCart(HttpSession session, int productNo, int productCount) {
		try {
			// ������ ����� ��ٱ��� ���� ��������
			List<StoreDTO> cart = (List<StoreDTO>) session.getAttribute("cart");

			if (cart == null) {
				// ���ǿ� ��ٱ��� ������ ������ ���ο� ����Ʈ ����
				cart = new ArrayList<>();
				session.setAttribute("cart", cart);
			}

			// ��ǰ��ȣ�� �ش� ��ǰ ���� ��������
			StoreDTO dto = getReadData(productNo);
			dto.setProductCount(productCount);
			dto.setProductPrice(dto.getProductPrice() * dto.getProductCount());

			if (dto != null) {
				// ��ٱ��Ͽ� ��ǰ �߰�
				cart.add(dto);
			} else {
				System.out.println("��ǰ�� �������� �ʽ��ϴ�. ");
			}
		} catch (Exception e) {
			System.out.println("��ٱ��� �߰� �� ���� �߻�: " + e.toString());
		}
	}

	// ������ٱ��Ͽ��� ��ǰ����
	public void removeCart(HttpSession session, int productNo) {
		try {
			// ���ǿ��� ��ٱ��� ���� ��������
			List<StoreDTO> cart = (List<StoreDTO>) session.getAttribute("cart");

			if (cart != null) {
				// ��ǰ��ȣ�� �ش� ��ǰ ã��
				for (StoreDTO dto : cart) {
					if (dto.getProductNo() == productNo) {
						// ��ǰ ����
						cart.remove(dto);
						break;
					}
				}
			}
		} catch (Exception e) {
			System.out.println("��ٱ��� ��ǰ ���� �� ���� �߻�: " + e.toString());
		}
	}

	// ��ٱ��� ���Ǹ���Ʈ ������
	public List<StoreDTO> getCartList(HttpSession session) {
		List<StoreDTO> cartList = null;

		try {
			// ���ǿ��� ��ٱ��� ���� ��������
			cartList = (List<StoreDTO>) session.getAttribute("cart");

			if (cartList == null) {
				// ��ٱ��ϰ� ������� ���, ���ο� ����Ʈ ����
				cartList = new ArrayList<>();
			}
		} catch (Exception e) {
			System.out.println("��ٱ��� ��� ��ȸ �� ���� �߻�: " + e.toString());
		}

		return cartList;
	}

}

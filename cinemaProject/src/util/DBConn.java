package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConn {

	private static Connection conn = null;

	public static Connection getConnection() {

		try {
			// thin 가장 최소한의 정보로 연결
			// 와이파이로 연결시 localhost로 연결
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "suzi";
			String pwd = "a123";

			if (conn == null) {
				// 클래스를 읽어옴
				Class.forName("oracle.jdbc.driver.OracleDriver");
				conn = DriverManager.getConnection(url, user, pwd);

			}

		} catch (Exception e) {
			System.out.println(e.toString());
		}

		return conn;

	}

	public static void close() {

		if (conn == null) {
			// 반응하지 않음
			return;
		}

		try {
			if (!conn.isClosed()) {
				// 콘이 열려있으면 닫음
				conn.close();
			}

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		conn = null;
	}
}
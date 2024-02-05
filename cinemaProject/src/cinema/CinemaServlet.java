package cinema;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson; // Gson import �߰�
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import util.DBConn;
import util.FileManager;
import util.MyUtill;

@WebServlet("/CinemaServlet")
public class CinemaServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	protected void forward(HttpServletRequest req, HttpServletResponse resp, String url)
			throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}

	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String cp = req.getContextPath();

		// dao ��ü ���� �� db ����
		Connection conn = DBConn.getConnection();

		// ����
		BookingDAO bookingDAO = new BookingDAO(conn);
		UserDAO userDAO = new UserDAO(conn);
		TheaterDAO theaterDAO = new TheaterDAO(conn);
		MovieDAO movieDAO = new MovieDAO(conn);

		// ���
		OrderDAO odao = new OrderDAO(conn);
		StoreDAO sdao = new StoreDAO(conn);
		UserDAO udao = new UserDAO(conn);

		// ��ȭ ������
		MovieComentDAO movieComentDAO = new MovieComentDAO(conn);

		MyUtill myutil = new MyUtill();

		// ����
		HttpSession session = req.getSession();
		CustomInfo info = new CustomInfo();

		// �̹��� ��Ʈ
		String root = getServletContext().getRealPath("/");
		String path = root + "pds" + File.separator + "imageFile";

		// �̹��� ���� ������ ����
		File f = new File(path);
		if (!f.exists()) {
			f.mkdirs();
		}

		// �ּ� ���� (cinemaProject/cinema/)
		String uri = req.getRequestURI();
		String url;

		if (uri.indexOf("main") != -1) {

			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);

			}

			int dataCount = sdao.getDataCount();

			int numPerPage = 3;

			int totalPage = myutil.getPageCount(numPerPage, dataCount);

			req.setAttribute("totalPage", totalPage);

			if (currentPage > totalPage) {
				currentPage = totalPage;
			}
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;
			int a = 0;

			// productNo 10������ 20������ ��ǰ����Ʈ(10~20���� ī��)
			List<StoreDTO> lists = sdao.getList(start, end, a);

			String listUrl = cp + "/cinema/cinemaStore";
			String pageIndexList = myutil.pageIndexList(currentPage, totalPage, listUrl);
			String imagePath = cp + "/pds/imageFile";

			// ������Ʈ
			List<MovieDTO> moivelists = movieDAO.getMovieLists();
			req.setAttribute("moivelists", moivelists);

			req.setAttribute("imagePath", imagePath);
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum", currentPage);

			String b = "";

			// 1������ 10������ ��ǰ����Ʈ(1~10���� ������)
			List<StoreDTO> lists2 = sdao.getList(start, end, b);

			req.setAttribute("lists2", lists2);

			url = "/cinemaProject/main.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("userCreate") != -1) {
			// ȸ������ ������
			url = "/cinemaProject/userCreate.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("membershipCreate_ok") != -1) {
			// ȸ������

			UserDTO dto = new UserDTO();

			dto.setUserId(req.getParameter("userId"));
			dto.setUserPw(req.getParameter("userPw"));
			dto.setUserName(req.getParameter("userName"));
			dto.setUserJumin(req.getParameter("userJumin"));
			dto.setUserTelecom(req.getParameter("userTelecom"));

			String userTel = req.getParameter("userTelFirst") + req.getParameter("userTelSecond")
					+ req.getParameter("userTelThird");
			dto.setUserTel(userTel);
			dto.setUserEmail(req.getParameter("userEmail"));
			dto.setSample4_postcode(req.getParameter("sample4_postcode"));
			dto.setSample4_roadAddress(req.getParameter("sample4_roadAddress"));
			dto.setSample4_jibunAddress(req.getParameter("sample4_jibunAddress"));
			dto.setSample4_detailAddress(req.getParameter("sample4_detailAddress"));
			dto.setSample4_extraAddress(req.getParameter("sample4_extraAddress"));

			udao.insertData(dto);

			url = cp + "/cinema/main";
			resp.sendRedirect(url);

		} else if (uri.indexOf("userLogin") != -1) {

			url = "/cinemaProject/userLogin.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("logout") != -1) {

			session.removeAttribute("customInfo");

			url = cp + "/cinema/main";
			resp.sendRedirect(url);

		} else if (uri.indexOf("findPw") != -1) {
			// ��й�ȣ ã��

			url = "/cinemaProject/findPw.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("findPassward_ok") != -1) {

			String userId = req.getParameter("userId");
			String userTel = req.getParameter("userTel");

			UserDTO dto = udao.getReadData(userId);

			if (dto == null || (!userTel.equals(dto.getUserTel()))) {
				req.setAttribute("message2", "ȸ�������� �������� �ʽ��ϴ�.");
				url = "/cinemaProject/findPw.jsp";
				forward(req, resp, url);

			} else {
				req.setAttribute("message2", "��й�ȣ�� [" + dto.getUserPw() + "]�Դϴ�.");
				url = "/cinemaProject/userLogin.jsp";
				forward(req, resp, url);
			}

		} else if (uri.indexOf("myCinema") != -1) {

			// ���� ���̵� ���ǿ��� �޾ƿ�
			session = req.getSession();
			CustomInfo customInfo = (CustomInfo) session.getAttribute("customInfo");
			String userId = customInfo.getUserId();

			UserDTO userDTO = userDAO.getReadData(userId);

			// ���� ����
			List<BookingDTO> bookingDTO = bookingDAO.getReadData(userId);

			req.setAttribute("userDTO", userDTO);
			req.setAttribute("bookingDTO", bookingDTO);

			url = "/cinemaProject/myCinema.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("update") != -1) {
			url = "/cinemaProject/update.jsp";
			forward(req, resp, url);
		} else if (uri.indexOf("udt") != -1) {

			session = req.getSession();
			CustomInfo customInfo = (CustomInfo) session.getAttribute("customInfo");
			String userId = customInfo.getUserId();

			String newPw = req.getParameter("newPw");
			udao.updateData(userId, newPw);

			resp.setContentType("text/html;charset=UTF-8");
			PrintWriter out = resp.getWriter();
			out.println("<html><head><script>");
			out.println("window.opener.location.reload();"); // �θ� â ���ΰ�ħ
			out.println("window.close();"); // ���� â �ݱ� out.println("</script>");
			out.println("</script></head><body></body></html>");
			out.flush();
			out.close();

		} else if (uri.indexOf("deleteMovie") != -1) {

			// ��ȭ ����, ���� ���̵�, �ο��� �޾ƿ�
			Long bookingNo = Long.parseLong(req.getParameter("bookingNo"));
			String userId = req.getParameter("userId");
			int theaterPerson = Integer.parseInt(req.getParameter("theaterPerson"));
			int theaterNo = Integer.parseInt(req.getParameter("theaterNo"));

			// System.out.println("theaterNo:" + theaterNo);
			// System.out.println("theaterPerson:" + theaterPerson);

			// ��ȭ ���� ���� �޼���
			bookingDAO.deleteMovie(bookingNo, userId);

			// ��ȭ�� ������Ʈ �޼���
			theaterDAO.deleteMovie(theaterNo, theaterPerson);

			// ���� ��� �� �ٽ� ���̽ó׸���
			url = cp + "/cinema/myCinema";
			resp.sendRedirect(url);

		} else if (uri.indexOf("memberLogin_ok") != -1) {

			String userId = req.getParameter("userId");
			String userPw = req.getParameter("userPw");

			UserDTO dto = udao.getReadData(userId);

			if (dto == null || (!dto.getUserPw().equals(userPw))) {
				req.setAttribute("message", "��й�ȣ�� Ʋ�Ƚ��ϴ�.");

				url = "/cinemaProject/userLogin.jsp";
				forward(req, resp, url);
				return;
			}

			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			info.setUserTel(dto.getUserTel());

			session.setAttribute("customInfo", info);

			if (session.getAttribute("customInfo") == null) {
				req.setAttribute("message1", "�α���");
			} else {
				req.setAttribute("message1", "�α׾ƿ�");
			}

			url = cp + "/cinema/main";
			resp.sendRedirect(url);

		} else if (uri.indexOf("inputStore.do") != -1) {

			url = "/cinemaProject/inputStore.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("inputStore_ok.do") != -1) {

			//
			String encType = "UTF-8";
			int maxSize = 10 * 1024 * 1024;

			MultipartRequest mr = new MultipartRequest(req, path, maxSize, encType, new DefaultFileRenamePolicy());

			// DB
			if (mr.getFile("upload") != null) {

				StoreDTO dto = new StoreDTO();

				dto.setProductNo(Integer.parseInt(mr.getParameter("productNo")));
				dto.setProductName(mr.getParameter("productName"));
				dto.setProductPrice(Integer.parseInt(mr.getParameter("productPrice")));
				dto.setProductContent(mr.getParameter("productContent"));
				dto.setSaveFileName(mr.getFilesystemName("upload"));
				dto.setOriginalFileName(mr.getOriginalFileName("upload"));
				sdao.insertData(dto);

			}

			url = cp + "/cinema/cinemaStore";
			resp.sendRedirect(url);

		} else if (uri.indexOf("cinemaStore") != -1) {
			// �����

			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);

			}

			int dataCount = sdao.getDataCount();

			int numPerPage = 9;

			int totalPage = myutil.getPageCount(numPerPage, dataCount);

			req.setAttribute("totalPage", totalPage);

			if (currentPage > totalPage) {
				currentPage = totalPage;
			}
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<StoreDTO> lists = sdao.getList(start, end);

			String listUrl = cp + "/cinema/cinemaStore";
			String pageIndexList = myutil.pageIndexList(currentPage, totalPage, listUrl);
			String deletePath = cp + "/cinema/delete";
			String downloadPath = cp + "/cinema/download.do";
			String imagePath = cp + "/pds/imageFile";

			req.setAttribute("imagePath", imagePath);
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("deletePath", deletePath);
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum", currentPage);

			url = "/cinemaProject/cinemaStore.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("productDetail.do") != -1) {

			int productNo = Integer.parseInt(req.getParameter("productNo"));
			StoreDTO productDetail = sdao.getReadData(productNo);
			req.setAttribute("productDetail", productDetail);

			url = "/cinemaProject/productDetail.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("productDetail_ok") != -1) {

			info = (CustomInfo) req.getSession().getAttribute("customInfo");

			if (info != null) {
				int productNo = Integer.parseInt(req.getParameter("productNo"));
				String productCount = req.getParameter("productCount");
				String redirectURL = cp + "/cinema/buyPage?productNo=" + productNo + "&productCount=" + productCount;
				resp.sendRedirect(redirectURL);
			} else {

				resp.sendRedirect(cp + "/cinema/userLogin.jsp");
			}

		} else if (uri.indexOf("cinemaTicket") != -1) {

			String pageNum = req.getParameter("pageNum");

			int currentPage = 1;

			if (pageNum != null) {
				currentPage = Integer.parseInt(pageNum);
			}

			int dataCount = sdao.getDataCount();

			int numPerPage = 9;

			int totalPage = myutil.getPageCount(numPerPage, dataCount);

			req.setAttribute("totalPage", totalPage);

			if (currentPage > totalPage) {
				currentPage = totalPage;
			}
			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			int a = 0;

			List<StoreDTO> lists = sdao.getList(start, end, a);

			String listUrl = cp + "/cinema/cinemaTicket";
			String pageIndexList = myutil.pageIndexList(currentPage, totalPage, listUrl);
			String deletePath = cp + "/cinema/delete";
			String downloadPath = cp + "/cinema/download.do";
			String imagePath = cp + "/pds/imageFile";

			req.setAttribute("imagePath", imagePath);
			req.setAttribute("downloadPath", downloadPath);
			req.setAttribute("deletePath", deletePath);
			req.setAttribute("lists", lists);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("dataCount", dataCount);
			req.setAttribute("pageNum", currentPage);

			url = "/cinemaProject/cinemaTicket.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("buyPage") != -1) {
			int productNo = Integer.parseInt(req.getParameter("productNo"));
			int productCount = Integer.parseInt(req.getParameter("productCount"));

			String imagePath = cp + "/pds/imageFile";

			StoreDTO dto = sdao.getReadData(productNo);

			dto.setProductCount(productCount);

			session.setAttribute("selectedProduct", dto);

			sdao.addCart(session, productNo, productCount);

			List<StoreDTO> cart = sdao.getCartList(session);
			int totalPaymentAmount = 0;
			for (StoreDTO item : cart) {
				totalPaymentAmount += item.getProductPrice();
			}
			req.setAttribute("totalPaymentAmount", totalPaymentAmount);

			req.setAttribute("imagePath", imagePath);

			// JSP
			url = "/cinemaProject/buyPage.jsp";

			// Forward
			forward(req, resp, url);

		} else if (uri.indexOf("removeCart") != -1) {

			int productNo = Integer.parseInt(req.getParameter("productNo"));

			sdao.removeCart(session, productNo);

			url = cp + "/cinema/cinemaStore";
			resp.sendRedirect(url);

		} else if (uri.indexOf("delete") != -1) {

			int productNo = Integer.parseInt(req.getParameter("productNo"));
			String pageNum = req.getParameter("pageNum");

			StoreDTO dto = sdao.getReadData(productNo);

			// DB
			sdao.deleteData(productNo);

			url = cp + "/cinema/cinemaStore.do?pageNum=" + pageNum;
			resp.sendRedirect(url);

		} else if (uri.indexOf("download.do") != -1) {
			int productNo = Integer.parseInt(req.getParameter("productNo"));

			StoreDTO dto = sdao.getReadData(productNo);

			if (dto == null) {
				return;
			}
			boolean flag = FileManager.doFileDownload(resp, dto.getSaveFileName(), dto.getOriginalFileName(), path);

			if (flag == false) {
				resp.setContentType("text/html;charset=UTF-8");

				PrintWriter out = resp.getWriter();
				out.print("<script type='text/javascript'>");
				out.print("alert('!!!');");
				out.print("history.back();");
				out.print("</script>");
			}

		} else if (uri.indexOf("booking") != -1) {
			// ��ȭ ���� ������

			// �α��� ���� ����
			session = req.getSession();
			CustomInfo customInfo = (CustomInfo) session.getAttribute("customInfo");

			// customInfoJson�� JSP�� ����
			String customInfoJson = new Gson().toJson(customInfo);
			req.setAttribute("customInfoJson", customInfoJson);

			// ��ü ��ȭ ����Ʈ ���
			List<MovieDTO> movieDTO = movieDAO.getMovieLists();
			req.setAttribute("movieDTO", movieDTO);

			// ������ �̵�
			url = "/cinemaProject/booking.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("loadTheaters") != -1) {
			// AJAX ��û ó��
			int movieNo = Integer.parseInt(req.getParameter("movieNo"));

			// �޼��� ����
			List<TheaterDTO> theaterDTO = theaterDAO.getTheaters(movieNo);

			// ���� ������ JSON �������� ��ȯ
			String jsonTheaters = new Gson().toJson(theaterDTO);

			// JSON �������� ������ ����
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write(jsonTheaters);

		} else if (uri.indexOf("loadDates") != -1) {
			// AJAX ��û ó��
			// ��ȭ �̸�, ���� ���� �� �޾ƿ�
			String theaterLocal = req.getParameter("theaterLocal");
			String movieName = req.getParameter("movieName");

			List<TheaterDTO> theaterDTO = theaterDAO.getDate(movieName, theaterLocal);

			// ���� ������ JSON �������� ��ȯ
			String jsonDates = new Gson().toJson(theaterDTO);

			// ���信 JSON �������� ������ ����
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write(jsonDates);

		} else if (uri.indexOf("loadTimes") != -1) {
			// AJAX ��û ó��
			// ��ȭ �̸�, ����, ��¥ �޾ƿ�
			String theaterLocal = req.getParameter("theaterLocal");
			String theaterDay = req.getParameter("theaterDay");
			String movieName = req.getParameter("movieName");

			List<TheaterDTO> theaterDTO = theaterDAO.getTime(movieName, theaterLocal, theaterDay);

			// ���� ������ JSON �������� ��ȯ
			String jsonDates = new Gson().toJson(theaterDTO);

			// ���信 JSON �������� ������ ����
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write(jsonDates);

		} else if (uri.indexOf("loadCk") != -1) {
			// AJAX ��û ó��
			// ��ȭ �̸�, ����, ��¥, �ð� �޾ƿ�
			String movieName = req.getParameter("movieName");
			String theaterLocal = req.getParameter("theaterLocal");
			String theaterDay = req.getParameter("theaterDay");
			String theaterTime = req.getParameter("theaterTime");

			// ��� ���� ������ �ִ� ��� 1��
			TheaterDTO theaterDTO = theaterDAO.getCk(movieName, theaterLocal, theaterDay, theaterTime);

			// ���� ������ JSON �������� ��ȯ
			String jsonCk = new Gson().toJson(theaterDTO);

			// ���信 JSON �������� ������ ����
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write(jsonCk);

		} else if (uri.indexOf("seatBooking") != -1) {

			// post�� �Ѿ�� �� ����
			String movieName = req.getParameter("movieName");
			String theaterLocal = req.getParameter("theaterLocal");
			String theaterDay = req.getParameter("theaterDay");
			String theaterTime = req.getParameter("theaterTime");

			/// ��� ���� ������ �ִ� ��� 1��
			TheaterDTO theaterDTO = theaterDAO.getCk(movieName, theaterLocal, theaterDay, theaterTime);

			// ���ŵ� �¼� ���� ����Ʈ
			List<BookingDTO> bookingDTO = bookingDAO.getTheaters(movieName, theaterLocal, theaterDay, theaterTime);

			// ���ŵ� �¼� json���� ����.
			String jsonBooking = new Gson().toJson(bookingDTO);

			req.setAttribute("theaterDTO", theaterDTO);
			req.setAttribute("bookingDTO", bookingDTO);
			req.setAttribute("jsonBooking", jsonBooking);

			// ������ �̵�
			url = "/cinemaProject/seatBooking.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("ticketPay") != -1) {
			// ��ȭ ������ �̹���
			String movieName = req.getParameter("movieName");

			MovieDTO movieDTO = movieDAO.getImage(movieName);

			int theaterNo = Integer.parseInt(req.getParameter("theaterNo"));

			// ���� �̸� (������ ���)
			session = req.getSession();
			CustomInfo customInfo = (CustomInfo) session.getAttribute("customInfo");
			String userName = customInfo.getUserName();

			req.setAttribute("userName", userName);
			req.setAttribute("theaterNo", theaterNo);
			req.setAttribute("movieDTO", movieDTO);

			url = "/cinemaProject/ticketPay.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("okPay") != -1) {
			// post�� �Ѿ�� �� ����
			BookingDTO bookingDTO = new BookingDTO();

			// ��ȭ ������ �̹���
			String moiveImage = req.getParameter("moiveImage");

			// ��ȭ Ƽ�� ����
			int ticketPrice = Integer.parseInt(req.getParameter("ticketPrice"));

			// System.out.println("Ƽ�ϰ���:" + ticketPrice);

			// ���� ���̵� ���ǿ��� �޾ƿ�
			session = req.getSession();
			CustomInfo customInfo = (CustomInfo) session.getAttribute("customInfo");
			String userId = customInfo.getUserId();

			bookingDTO.setBookingNo(Long.parseLong(req.getParameter("movieTicket")));
			bookingDTO.setMovieName(req.getParameter("movieName"));
			bookingDTO.setMovieImg(moiveImage);
			bookingDTO.setUserId(userId);
			bookingDTO.setTheaterNo(Integer.parseInt(req.getParameter("theaterNo")));
			bookingDTO.setTheaterLocal(req.getParameter("theaterLocal"));
			bookingDTO.setTheaterDay(req.getParameter("theaterDay"));
			bookingDTO.setTheaterTime(req.getParameter("theaterTime"));
			bookingDTO.setTheaterPerson(Integer.parseInt(req.getParameter("theaterPerson")));
			bookingDTO.setTheaterTicket(req.getParameter("theaterTicket"));
			bookingDTO.setTicketPrice(ticketPrice);

			// ���� DAO
			// ���� �μ�Ʈ ����
			// int getNo = bookingDAO.getMaxNo() + 1;
			bookingDAO.insertBooking(bookingDTO);

			// �¼� ���� �޼���
			theaterDAO.updateSeat(bookingDTO);

			// �������� ����
			req.setAttribute("bookingDTO", bookingDTO);
			req.setAttribute("moiveImage", moiveImage);

			url = "/cinemaProject/okPay.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("schedule") != -1) {
			// �󿵽����� ������

			// �α��� ���� ����
			session = req.getSession();
			CustomInfo customInfo = (CustomInfo) session.getAttribute("customInfo");

			// customInfoJson�� JSP�� ����
			String customInfoJson = new Gson().toJson(customInfo);
			req.setAttribute("customInfoJson", customInfoJson);

			// �󿵰� ��� (�ߺ� ����)
			List<TheaterDTO> theaterDTO = new ArrayList<TheaterDTO>();
			theaterDTO = theaterDAO.getTheater();

			req.setAttribute("theaterDTO", theaterDTO);

			url = "/cinemaProject/schedule.jsp";
			forward(req, resp, url);
		} else if (uri.indexOf("getMoives") != -1) {
			// AJAX ��û ó��
			String theaterLocal = req.getParameter("theaterLocal");

			System.out.println("theaterLocal:" + theaterLocal);

			// ��ü ��� �޼��� ����
			List<TheaterDTO> theaterDTO = theaterDAO.localTheaters(theaterLocal);

			// ������ ��ȭ ���� �޼���
			int getTotalMovie = theaterDAO.getTotalMovie(theaterLocal);

			// ���� ������ JSON �������� ��ȯ
			String jsonTheaters = new Gson().toJson(theaterDTO);

			req.setAttribute("getTotalMovie", getTotalMovie);

			// JSON �������� ������ ����
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			resp.getWriter().write(jsonTheaters);

		} else if (uri.indexOf("movieAll") != -1) {

			List<MovieDTO> lists = movieDAO.getMovieLists();

			req.setAttribute("lists", lists);

			url = "/cinemaProject/movieAll.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("movieDetail") != -1) {

			int movieNo = Integer.parseInt(req.getParameter("movieno"));

			CustomInfo customInfo = (CustomInfo) session.getAttribute("customInfo");

			String userName = null;
			String userId = null;

			// CustomInfo ��ü�� ���ǿ� �����ϴ� ���, ����� ������ �����ɴϴ�.
			if (customInfo != null) {
				userId = customInfo.getUserId();

			}

			// ����� ������ ��û �Ӽ��� �����մϴ�.
			req.setAttribute("userName", userName);
			req.setAttribute("userId", userId);

			MovieDTO Moviedto = movieDAO.getReadData(movieNo);
			req.setAttribute("Moviedto", Moviedto);

			String pageNum = req.getParameter("pageNum");
			int currentPage = (pageNum != null) ? Integer.parseInt(pageNum) : 1;

			int dataCount = movieComentDAO.getDataCount(movieNo);
			int numPerPage = 6;
			int totalPage = myutil.getPageCount(numPerPage, dataCount);

			currentPage = Math.min(currentPage, totalPage);
			currentPage = (totalPage > 0) ? currentPage : 1;

			int start = (currentPage - 1) * numPerPage + 1;
			int end = currentPage * numPerPage;

			List<MovieComentDTO> comentList = movieComentDAO.getListsReview(start, end, movieNo);

			String listUrl = cp + "/cinema/movieDetail.do?movieno=" + movieNo;
			String pageIndexList = myutil.pageIndexList(currentPage, totalPage, listUrl);

			req.setAttribute("movieNo", movieNo);
			req.setAttribute("comentList", comentList);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("totalPage", totalPage);
			req.setAttribute("pageIndexList", pageIndexList);
			req.setAttribute("listUrl", listUrl);

			String deleteNumStr = req.getParameter("deleteNum");
			if (deleteNumStr != null && !deleteNumStr.isEmpty()) {
				int deleteNum = Integer.parseInt(deleteNumStr);
				movieComentDAO.redeleteData(deleteNum);

				// ���� ���� �� ������ �����̷�Ʈ
				resp.sendRedirect(cp + "/cinema/movieDetail?movieno=" + movieNo);
				return;
			}

			url = "/cinemaProject/movieDetail.jsp";
			forward(req, resp, url);

		} else if (uri.indexOf("detail_ok") != -1) {

			int movieNo = Integer.parseInt(req.getParameter("movieNo"));
			String userId = req.getParameter("userId");

			int num = movieComentDAO.getMaxNumReview() + 1;

			MovieComentDTO reviewdto = new MovieComentDTO();

			reviewdto.setComentNo(num);
			reviewdto.setName(userId);
			reviewdto.setComentContent(req.getParameter("comentContent"));
			reviewdto.setMovieNo(movieNo);

			movieComentDAO.insertReview(reviewdto);

			resp.sendRedirect(cp + "/cinema/movieDetail?movieno=" + movieNo);

		}

	}
}

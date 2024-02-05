package util;

//page처리 클래스

public class MyUtill {

	// 전체 페이지의 갯수
	public int getPageCount(int numPerPage, int dataCount) {

		int pageCount = 0;

		pageCount = dataCount / numPerPage;

		if (dataCount % numPerPage != 0) {
			pageCount++;

		}
		return pageCount;
	}

	// 페이징 처리 메소드
	public String pageIndexList(int currentPage, int totalPage, String listUrl) {

		int numPerBlock = 5;
		int currentPageSetup;
		int page;

		StringBuffer sb = new StringBuffer();
		if (currentPage == 0 || totalPage == 0) {
			return "";
		}

		// list.jsp
		// list.jsp?searchKey=name&searchValue=suzi

		if (listUrl.indexOf("?") != -1) {
			listUrl = listUrl + "&";
		} else {
			listUrl = listUrl + "?";
		}
		currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
		if (currentPage % numPerBlock == 0) {
			currentPageSetup = currentPageSetup - numPerBlock;
		}
		// ◀이전
		if (totalPage > numPerBlock & currentPageSetup > 0) {
			sb.append("<a href=\"" + listUrl + "pageNum=" + currentPageSetup + "\">◀이전</a>&nbsp;");
			// <a href="list.jsp?"pageNum=5">◀이전</a>&nbsp;
		}

		// 바로가기 페이지

		page = currentPageSetup + 1;

		while (page <= totalPage && page <= (currentPageSetup + numPerBlock)) {
			if (page == currentPage) {
				sb.append("<font color=\"#FF4357\">" + page + "</font>&nbsp;");
				// <font color = "Fuchsia">9</font>&nbsp;
			} else {
				sb.append("<a href=\"" + listUrl + "pageNum=" + page + "\">" + page + "</a>&nbsp;");
				// <a href = "list.jsp?pageNum=2">2</a>&nbsp;
			}
			page++;
		}
		// 다음▶
		if (totalPage - currentPageSetup > numPerBlock) {
			sb.append("<a href=\"" + listUrl + "pageNum=" + page + "\">다음▶</a>&nbsp;");

			// <a href="list.jsp?pageNum=11">다음▶</a>&nbsp;
		}

		return sb.toString();
	}

	public String pageIndexList2(int currentPage, int totalPage, String listUrl) {

		int numPerBlock = 5;
		int currentPageSetup;
		int page;

		StringBuffer sb = new StringBuffer();
		if (currentPage == 0 || totalPage == 0) {
			return "";
		}

		// list.jsp
		// list.jsp?searchKey=name&searchValue=suzi

		if (listUrl.indexOf("?") != -1) {
			listUrl = listUrl + "&";
		} else {
			listUrl = listUrl + "?";
		}
		currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
		if (currentPage % numPerBlock == 0) {
			currentPageSetup = currentPageSetup - numPerBlock;
		}
		// ◀이전
		if (totalPage > numPerBlock & currentPageSetup > 0) {
			sb.append("<a href=\"" + listUrl + "id=" + currentPageSetup + "\">◀이전</a>&nbsp;");
			// <a href="list.jsp?"pageNum=5">◀이전</a>&nbsp;
		}

		// 바로가기 페이지

		page = currentPageSetup + 1;

		while (page <= totalPage && page <= (currentPageSetup + numPerBlock)) {
			if (page == currentPage) {
				sb.append("<font color=\"#FF4357\">" + page + "</font>&nbsp;");
				// <font color = "Fuchsia">9</font>&nbsp;
			} else {
				sb.append("<a href=\"" + listUrl + "id=" + page + "\">" + page + "</a>&nbsp;");
				// <a href = "list.jsp?pageNum=2">2</a>&nbsp;
			}
			page++;
		}
		// 다음▶
		if (totalPage - currentPageSetup > numPerBlock) {
			sb.append("<a href=\"" + listUrl + "id=" + page + "\">다음▶</a>&nbsp;");

			// <a href="list.jsp?pageNum=11">다음▶</a>&nbsp;
		}

		return sb.toString();
	}

}

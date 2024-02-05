package cinema;

public class BookingDTO {

	private Long bookingNo;
	private String userId;
	private String movieName;
	private String movieImg;
	private int theaterNo;
	private String theaterLocal;
	private String theaterDay;
	private String theaterTime;
	private int theaterPerson;
	private String theaterTicket;
	private int ticketPrice;

	public int getTheaterNo() {
		return theaterNo;
	}

	public void setTheaterNo(int theaterNo) {
		this.theaterNo = theaterNo;
	}

	public String getMovieImg() {
		return movieImg;
	}

	public void setMovieImg(String movieImg) {
		this.movieImg = movieImg;
	}

	public int getTicketPrice() {
		return ticketPrice;
	}

	public void setTicketPrice(int ticketPrice) {
		this.ticketPrice = ticketPrice;
	}

	public Long getBookingNo() {
		return bookingNo;
	}

	public void setBookingNo(Long bookingNo) {
		this.bookingNo = bookingNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getMovieName() {
		return movieName;
	}

	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}

	public String getTheaterLocal() {
		return theaterLocal;
	}

	public void setTheaterLocal(String theaterLocal) {
		this.theaterLocal = theaterLocal;
	}

	public String getTheaterDay() {
		return theaterDay;
	}

	public void setTheaterDay(String theaterDay) {
		this.theaterDay = theaterDay;
	}

	public String getTheaterTime() {
		return theaterTime;
	}

	public void setTheaterTime(String theaterTime) {
		this.theaterTime = theaterTime;
	}

	public int getTheaterPerson() {
		return theaterPerson;
	}

	public void setTheaterPerson(int theaterPerson) {
		this.theaterPerson = theaterPerson;
	}

	public String getTheaterTicket() {
		return theaterTicket;
	}

	public void setTheaterTicket(String theaterTicket) {
		this.theaterTicket = theaterTicket;
	}

}

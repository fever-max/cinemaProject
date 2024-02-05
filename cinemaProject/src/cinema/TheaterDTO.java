package cinema;

public class TheaterDTO {

	private int theaterNo;
	private int movieNo;
	private String movieName;
	private String theaterLocal;
	private String theaterDay;
	private String theaterTime;
	private int theaterFullSeats;
	private int theaterNowSeats;

	public int getTheaterNo() {
		return theaterNo;
	}

	public void setTheaterNo(int theaterNo) {
		this.theaterNo = theaterNo;
	}

	public int getMovieNo() {
		return movieNo;
	}

	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}

	public String getMovieName() {
		return movieName;
	}

	public void setMovieName(String movieName) {
		this.movieName = movieName;
	}

	public int getTheaterFullSeats() {
		return theaterFullSeats;
	}

	public void setTheaterFullSeats(int theaterFullSeats) {
		this.theaterFullSeats = theaterFullSeats;
	}

	public int getTheaterNowSeats() {
		return theaterNowSeats;
	}

	public void setTheaterNowSeats(int theaterNowSeats) {
		this.theaterNowSeats = theaterNowSeats;
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

	public String getTheaterLocal() {
		return theaterLocal;
	}

	public void setTheaterLocal(String theaterLocal) {
		this.theaterLocal = theaterLocal;
	}

}

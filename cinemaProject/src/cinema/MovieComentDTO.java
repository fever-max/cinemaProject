package cinema;

public class MovieComentDTO {

	private int comentNo;
	private String name;
	private String comentContent;
	private String comentCreated;
	private int movieNo;

	public int getComentNo() {
		return comentNo;
	}

	public void setComentNo(int comentNo) {
		this.comentNo = comentNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getComentContent() {
		return comentContent;
	}

	public void setComentContent(String comentContent) {
		this.comentContent = comentContent;
	}

	public String getComentCreated() {
		return comentCreated;
	}

	public void setComentCreated(String comentCreated) {
		this.comentCreated = comentCreated;
	}

	public int getMovieNo() {
		return movieNo;
	}

	public void setMovieNo(int movieNo) {
		this.movieNo = movieNo;
	}

}

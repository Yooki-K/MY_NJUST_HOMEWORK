package javaBean;

public class student {
	private String name;
	private String id;
	private float score;
	private int rank;
	public student(String name,String id,float score,int rank) {
		setId(id);
		setRank(rank);
		setScore(score);
		setName(name);
	}


	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public float getScore() {
		return score;
	}
	public void setScore(float score) {
		this.score = score;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	
}

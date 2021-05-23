package javaBean;


public class Login {
	private String user;
	private String pwd;
	private String college;
	private String system;
	private String name;
	public Login() {
		
	}
	public Login(String user,String pwd,String college,String system) {
		setUser(user);
		setPwd(pwd);
		setCollege(college);
		setSystem(system);
		setName("");
	}
	
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public String getSystem() {
		return system;
	}
	public void setSystem(String system) {
		this.system = system;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}

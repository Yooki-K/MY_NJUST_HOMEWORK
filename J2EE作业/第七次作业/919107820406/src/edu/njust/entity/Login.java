package edu.njust.entity;

public class Login {
	private String user;
    private String name;
    private String pwd;  
    
    public Login(){}
    
    public Login(String user, String pwd) {
		super();
		this.user = user;
		this.pwd = pwd;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	
    
    
}

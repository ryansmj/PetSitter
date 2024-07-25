package vo;

public class AdminVO {
	private int admin_idx, admin_type;
	private String admin_id, admin_pwd, admin_name, admin_tel, admin_regdate;
	
	public int getAdmin_idx() {
		return admin_idx;
	}
	public void setAdmin_idx(int admin_idx) {
		this.admin_idx = admin_idx;
	}
	public int getAdmin_type() {
		return admin_type;
	}
	public void setAdmin_type(int admin_type) {
		this.admin_type = admin_type;
	}
	public String getAdmin_id() {
		return admin_id;
	}
	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}
	public String getAdmin_pwd() {
		return admin_pwd;
	}
	public void setAdmin_pwd(String admin_pwd) {
		this.admin_pwd = admin_pwd;
	}
	public String getAdmin_name() {
		return admin_name;
	}
	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}
	public String getAdmin_tel() {
		return admin_tel;
	}
	public void setAdmin_tel(String admin_tel) {
		this.admin_tel = admin_tel;
	}
	public String getAdmin_regdate() {
		return admin_regdate;
	}
	public void setAdmin_regdate(String admin_regdate) {
		this.admin_regdate = admin_regdate;
	}
}

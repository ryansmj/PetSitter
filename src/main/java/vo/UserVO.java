package vo;

import org.springframework.web.multipart.MultipartFile;

public class UserVO {
	private int user_idx, dog_age; 
	
	private String user_id, user_type, user_pwd, user_name, user_tel, user_birth, 
	user_gender, user_email, user_postcode,
	user_address, user_detailaddress, user_extraaddress, user_regdate, dog_user_idx, dog_name;

	private MultipartFile photo;
	
	
	
	
	public String getDog_user_idx() {
		return dog_user_idx;
	}

	public void setDog_user_idx(String dog_user_idx) {
		this.dog_user_idx = dog_user_idx;
	}

	public String getDog_name() {
		return dog_name;
	}

	public void setDog_name(String dog_name) {
		this.dog_name = dog_name;
	}


	public int getDog_age() {
		return dog_age;
	}

	public void setDog_age(int dog_age) {
		this.dog_age = dog_age;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
// 7/5
	public String getUser_type() {
		return user_type;
	}

	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_tel() {
		return user_tel;
	}

	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}

	public String getUser_birth() {
		return user_birth;
	}

	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}

	public String getUser_gender() {
		return user_gender;
	}

	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_postcode() {
		return user_postcode;
	}

	public void setUser_postcode(String user_postcode) {
		this.user_postcode = user_postcode;
	}

	public String getUser_address() {
		return user_address;
	}

	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	public String getUser_detailaddress() {
		return user_detailaddress;
	}

	public void setUser_detailaddress(String user_detailaddress) {
		this.user_detailaddress = user_detailaddress;
	}

	public String getUser_extraaddress() {
		return user_extraaddress;
	}

	public void setUser_extraaddress(String user_extraaddress) {
		this.user_extraaddress = user_extraaddress;
	}

	public String getUser_regdate() {
		return user_regdate;
	}

	public void setUser_regdate(String user_regdate) {
		this.user_regdate = user_regdate;
	}

	public MultipartFile getPhoto() {
		return photo;
	}

	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}
}

package vo;

import org.springframework.web.multipart.MultipartFile;

public class DoginfoVO {
	
	private int dog_user_idx,dog_age,dog_idx;
	private String dog_name,dog_size,dog_care,dog_photo_name;
	
	private MultipartFile dog_photo;
	
	
	public int getDog_age() {
		return dog_age;
	}
	public void setDog_age(int dog_age) {
		this.dog_age = dog_age;
	}
	public String getDog_name() {
		return dog_name;
	}
	public void setDog_name(String dog_name) {
		this.dog_name = dog_name;
	}

	
	public String getDog_size() {
		return dog_size;
	}
	public void setDog_size(String dog_size) {
		this.dog_size = dog_size;
	}
	public String getDog_care() {
		return dog_care;
	}
	public void setDog_care(String dog_care) {
		this.dog_care = dog_care;
	}
	
	public int getDog_user_idx() {
		return dog_user_idx;
	}
	public void setDog_user_idx(int dog_idx) {
		this.dog_user_idx = dog_idx;
	}
	public String getDog_photo_name() {
		return dog_photo_name;
	}
	public void setDog_photo_name(String dog_photo_name) {
		this.dog_photo_name = dog_photo_name;
	}
	public MultipartFile getDog_photo() {
		return dog_photo;
	}
	public void setDog_photo(MultipartFile dog_photo) {
		this.dog_photo = dog_photo;
	}
	public int getDog_idx() {
		return dog_idx;
	}
	public void setDog_idx(int dog_idx) {
		this.dog_idx = dog_idx;
	}
	
	
	
    
	
	
	
	
	
	
	
		
	
}

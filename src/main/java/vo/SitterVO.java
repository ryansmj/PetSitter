package vo;

import org.springframework.web.multipart.MultipartFile;

public class SitterVO {
	private String user_name, sitter_title, sitter_city, sitter_district,
	sitter_care, sitter_walk, sitter_pickup, sitter_bath, sitter_olddog,
	sitter_house, sitter_dogcount, sitter_kid, sitter_homecam, sitter_fence, sitter_pet,
	sitter_small, sitter_medium, sitter_large,
	sitter_start_time, sitter_end_time, 
	sitter_introduce,
	sitter_license_name1, sitter_license_auth1, sitter_license_date1, 
	sitter_license_name2, sitter_license_auth2, sitter_license_date2, 
	sitter_license_name3, sitter_license_auth3, sitter_license_date3, 
	sitter_can, sitter_cant,
	regdate, sitterApproval_status;
	

	private MultipartFile sitter_house1, sitter_house2, sitter_house3, 
	sitter_license_photo1, sitter_license_photo2, sitter_license_photo3;
	
	private String house1_name, house2_name, house3_name,
	license_photo1_name, license_photo2_name, license_photo3_name; 
	
	private int user_idx, sitter_idx, sitter_price_half, sitter_price_full;

	public String getSitterApproval_status() {
		return sitterApproval_status;
	}
	
	public void setSitterApproval_status(String sitterApproval_status) {
		this.sitterApproval_status = sitterApproval_status;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getSitter_title() {
		return sitter_title;
	}

	public void setSitter_title(String sitter_title) {
		this.sitter_title = sitter_title;
	}

	public String getSitter_city() {
		return sitter_city;
	}

	public void setSitter_city(String sitter_city) {
		this.sitter_city = sitter_city;
	}

	public String getSitter_district() {
		return sitter_district;
	}

	public void setSitter_district(String sitter_district) {
		this.sitter_district = sitter_district;
	}

	public String getSitter_care() {
		return sitter_care;
	}

	public void setSitter_care(String sitter_care) {
		this.sitter_care = sitter_care;
	}

	public String getSitter_walk() {
		return sitter_walk;
	}

	public void setSitter_walk(String sitter_walk) {
		this.sitter_walk = sitter_walk;
	}

	public String getSitter_pickup() {
		return sitter_pickup;
	}

	public void setSitter_pickup(String sitter_pickup) {
		this.sitter_pickup = sitter_pickup;
	}

	public String getSitter_bath() {
		return sitter_bath;
	}

	public void setSitter_bath(String sitter_bath) {
		this.sitter_bath = sitter_bath;
	}

	public String getSitter_olddog() {
		return sitter_olddog;
	}

	public void setSitter_olddog(String sitter_olddog) {
		this.sitter_olddog = sitter_olddog;
	}

	public String getSitter_house() {
		return sitter_house;
	}

	public void setSitter_house(String sitter_house) {
		this.sitter_house = sitter_house;
	}

	public String getSitter_dogcount() {
		return sitter_dogcount;
	}

	public void setSitter_dogcount(String sitter_dogcount) {
		this.sitter_dogcount = sitter_dogcount;
	}

	public String getSitter_kid() {
		return sitter_kid;
	}

	public void setSitter_kid(String sitter_kid) {
		this.sitter_kid = sitter_kid;
	}

	public String getSitter_homecam() {
		return sitter_homecam;
	}

	public void setSitter_homecam(String sitter_homecam) {
		this.sitter_homecam = sitter_homecam;
	}

	public String getSitter_fence() {
		return sitter_fence;
	}

	public void setSitter_fence(String sitter_fence) {
		this.sitter_fence = sitter_fence;
	}

	public String getSitter_pet() {
		return sitter_pet;
	}

	public void setSitter_pet(String sitter_pet) {
		this.sitter_pet = sitter_pet;
	}

	public String getSitter_small() {
		return sitter_small;
	}

	public void setSitter_small(String sitter_small) {
		this.sitter_small = sitter_small;
	}

	public String getSitter_medium() {
		return sitter_medium;
	}

	public void setSitter_medium(String sitter_medium) {
		this.sitter_medium = sitter_medium;
	}

	public String getSitter_large() {
		return sitter_large;
	}

	public void setSitter_large(String sitter_large) {
		this.sitter_large = sitter_large;
	}

	public String getSitter_start_time() {
		return sitter_start_time;
	}

	public void setSitter_start_time(String sitter_start_time) {
		this.sitter_start_time = sitter_start_time;
	}

	public String getSitter_end_time() {
		return sitter_end_time;
	}

	public void setSitter_end_time(String sitter_end_time) {
		this.sitter_end_time = sitter_end_time;
	}

	public String getSitter_introduce() {
		return sitter_introduce;
	}

	public void setSitter_introduce(String sitter_introduce) {
		this.sitter_introduce = sitter_introduce;
	}

	public String getSitter_license_name1() {
		return sitter_license_name1;
	}

	public void setSitter_license_name1(String sitter_license_name1) {
		this.sitter_license_name1 = sitter_license_name1;
	}

	public String getSitter_license_auth1() {
		return sitter_license_auth1;
	}

	public void setSitter_license_auth1(String sitter_license_auth1) {
		this.sitter_license_auth1 = sitter_license_auth1;
	}

	public String getSitter_license_date1() {
		return sitter_license_date1;
	}

	public void setSitter_license_date1(String sitter_license_date1) {
		this.sitter_license_date1 = sitter_license_date1;
	}

	public String getSitter_license_name2() {
		return sitter_license_name2;
	}

	public void setSitter_license_name2(String sitter_license_name2) {
		this.sitter_license_name2 = sitter_license_name2;
	}

	public String getSitter_license_auth2() {
		return sitter_license_auth2;
	}

	public void setSitter_license_auth2(String sitter_license_auth2) {
		this.sitter_license_auth2 = sitter_license_auth2;
	}

	public String getSitter_license_date2() {
		return sitter_license_date2;
	}

	public void setSitter_license_date2(String sitter_license_date2) {
		this.sitter_license_date2 = sitter_license_date2;
	}

	public String getSitter_license_name3() {
		return sitter_license_name3;
	}

	public void setSitter_license_name3(String sitter_license_name3) {
		this.sitter_license_name3 = sitter_license_name3;
	}

	public String getSitter_license_auth3() {
		return sitter_license_auth3;
	}

	public void setSitter_license_auth3(String sitter_license_auth3) {
		this.sitter_license_auth3 = sitter_license_auth3;
	}

	public String getSitter_license_date3() {
		return sitter_license_date3;
	}

	public void setSitter_license_date3(String sitter_license_date3) {
		this.sitter_license_date3 = sitter_license_date3;
	}

	public String getSitter_can() {
		return sitter_can;
	}

	public void setSitter_can(String sitter_can) {
		this.sitter_can = sitter_can;
	}

	public String getSitter_cant() {
		return sitter_cant;
	}

	public void setSitter_cant(String sitter_cant) {
		this.sitter_cant = sitter_cant;
	}

	public MultipartFile getSitter_house1() {
		return sitter_house1;
	}

	public void setSitter_house1(MultipartFile sitter_house1) {
		this.sitter_house1 = sitter_house1;
	}

	public MultipartFile getSitter_house2() {
		return sitter_house2;
	}

	public void setSitter_house2(MultipartFile sitter_house2) {
		this.sitter_house2 = sitter_house2;
	}

	public MultipartFile getSitter_house3() {
		return sitter_house3;
	}

	public void setSitter_house3(MultipartFile sitter_house3) {
		this.sitter_house3 = sitter_house3;
	}

	public MultipartFile getSitter_license_photo1() {
		return sitter_license_photo1;
	}

	public void setSitter_license_photo1(MultipartFile sitter_license_photo1) {
		this.sitter_license_photo1 = sitter_license_photo1;
	}

	public MultipartFile getSitter_license_photo2() {
		return sitter_license_photo2;
	}

	public void setSitter_license_photo2(MultipartFile sitter_license_photo2) {
		this.sitter_license_photo2 = sitter_license_photo2;
	}

	public MultipartFile getSitter_license_photo3() {
		return sitter_license_photo3;
	}

	public void setSitter_license_photo3(MultipartFile sitter_license_photo3) {
		this.sitter_license_photo3 = sitter_license_photo3;
	}

	public String getHouse1_name() {
		return house1_name;
	}

	public void setHouse1_name(String house1_name) {
		this.house1_name = house1_name;
	}

	public String getHouse2_name() {
		return house2_name;
	}

	public void setHouse2_name(String house2_name) {
		this.house2_name = house2_name;
	}

	public String getHouse3_name() {
		return house3_name;
	}

	public void setHouse3_name(String house3_name) {
		this.house3_name = house3_name;
	}

	public String getLicense_photo1_name() {
		return license_photo1_name;
	}

	public void setLicense_photo1_name(String license_photo1_name) {
		this.license_photo1_name = license_photo1_name;
	}

	public String getLicense_photo2_name() {
		return license_photo2_name;
	}

	public void setLicense_photo2_name(String license_photo2_name) {
		this.license_photo2_name = license_photo2_name;
	}

	public String getLicense_photo3_name() {
		return license_photo3_name;
	}

	public void setLicense_photo3_name(String license_photo3_name) {
		this.license_photo3_name = license_photo3_name;
	}

	public int getSitter_idx() {
		return sitter_idx;
	}

	public void setSitter_idx(int sitter_idx) {
		this.sitter_idx = sitter_idx;
	}

	public int getSitter_price_half() {
		return sitter_price_half;
	}

	public void setSitter_price_half(int sitter_price_half) {
		this.sitter_price_half = sitter_price_half;
	}

	public int getSitter_price_full() {
		return sitter_price_full;
	}

	public void setSitter_price_full(int sitter_price_full) {
		this.sitter_price_full = sitter_price_full;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
}
 
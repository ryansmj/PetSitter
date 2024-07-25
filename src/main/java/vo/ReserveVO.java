package vo;

public class ReserveVO { // 7/3
	private String reserve_user_name, reserve_sitter_name, reserve_city, reserve_district, reserve_size, 
			reserve_care, reserve_walk, reserve_pickup,
			reserve_type, reserve_start, reserve_end, 
			reserve_memo, reserve_status, reserve_regdate; // 7/4 reserve_status 추가
			
	private int reserve_idx, reserve_user_idx, reserve_sitter_idx, reserve_cancel; // 7/4 reserve_status 추가

	
	public String getReserve_user_name() {
		return reserve_user_name;
	}

	public void setReserve_user_name(String reserve_user_name) {
		this.reserve_user_name = reserve_user_name;
	}

	public String getReserve_sitter_name() {
		return reserve_sitter_name;
	}

	public void setReserve_sitter_name(String reserve_sitter_name) {
		this.reserve_sitter_name = reserve_sitter_name;
	}

	public String getReserve_city() {
		return reserve_city;
	}

	public void setReserve_city(String reserve_city) {
		this.reserve_city = reserve_city;
	}

	public String getReserve_district() {
		return reserve_district;
	}

	public void setReserve_district(String reserve_district) {
		this.reserve_district = reserve_district;
	}

	public String getReserve_size() {
		return reserve_size;
	}

	public void setReserve_size(String reserve_size) {
		this.reserve_size = reserve_size;
	}

	public String getReserve_care() {
		return reserve_care;
	}

	public void setReserve_care(String reserve_care) {
		this.reserve_care = reserve_care;
	}

	public String getReserve_walk() {
		return reserve_walk;
	}

	public void setReserve_walk(String reserve_walk) {
		this.reserve_walk = reserve_walk;
	}

	public String getReserve_pickup() {
		return reserve_pickup;
	}

	public void setReserve_pickup(String reserve_pickup) {
		this.reserve_pickup = reserve_pickup;
	}

	public String getReserve_type() {
		return reserve_type;
	}

	public void setReserve_type(String reserve_type) {
		this.reserve_type = reserve_type;
	}

	public String getReserve_start() {
		return reserve_start;
	}

	public void setReserve_start(String reserve_start) {
		this.reserve_start = reserve_start;
	}

	public String getReserve_end() {
		return reserve_end;
	}

	public void setReserve_end(String reserve_end) {
		this.reserve_end = reserve_end;
	}

	public String getReserve_memo() {
		return reserve_memo;
	}

	public void setReserve_memo(String reserve_memo) {
		this.reserve_memo = reserve_memo;
	}

	public String getReserve_status() {
		return reserve_status;
	}

	public void setReserve_status(String reserve_status) {
		this.reserve_status = reserve_status;
	}

	public String getReserve_regdate() {
		return reserve_regdate;
	}

	public void setReserve_regdate(String reserve_regdate) {
		this.reserve_regdate = reserve_regdate;
	}

	public int getReserve_idx() {
		return reserve_idx;
	}

	public void setReserve_idx(int reserve_idx) {
		this.reserve_idx = reserve_idx;
	}

	public int getReserve_user_idx() {
		return reserve_user_idx;
	}

	public void setReserve_user_idx(int reserve_user_idx) {
		this.reserve_user_idx = reserve_user_idx;
	}

	public int getReserve_sitter_idx() {
		return reserve_sitter_idx;
	}

	public void setReserve_sitter_idx(int reserve_sitter_idx) {
		this.reserve_sitter_idx = reserve_sitter_idx;
	}

	public int getReserve_cancel() {
		return reserve_cancel;
	}

	public void setReserve_cancel(int reserve_cancel) {
		this.reserve_cancel = reserve_cancel;
	}
	
}

package vo;

import org.springframework.web.multipart.MultipartFile;

public class OneInquiryVO {
	private int oneinquiry_idx, oneinquiry_user_idx;
	private String oneinquiry_title, oneinquiry_category, oneinquiry_content,
			oneinquiry_filename, oneinquiry_filetype, oneinquiry_regdate, oneinquiry_status;
	
	private MultipartFile oneinquiry_file;
	

	public int getOneinquiry_idx() {
		return oneinquiry_idx;
	}

	public void setOneinquiry_idx(int oneinquiry_idx) {
		this.oneinquiry_idx = oneinquiry_idx;
	}

	public int getOneinquiry_user_idx() {
		return oneinquiry_user_idx;
	}

	public void setOneinquiry_user_idx(int oneinquiry_user_idx) {
		this.oneinquiry_user_idx = oneinquiry_user_idx;
	}

	public String getOneinquiry_title() {
		return oneinquiry_title;
	}

	public void setOneinquiry_title(String oneinquiry_title) {
		this.oneinquiry_title = oneinquiry_title;
	}

	public String getOneinquiry_category() {
		return oneinquiry_category;
	}

	public void setOneinquiry_category(String oneinquiry_category) {
		this.oneinquiry_category = oneinquiry_category;
	}

	public String getOneinquiry_content() {
		return oneinquiry_content;
	}

	public void setOneinquiry_content(String oneinquiry_content) {
		this.oneinquiry_content = oneinquiry_content;
	}

	public String getOneinquiry_filename() {
		return oneinquiry_filename;
	}

	public void setOneinquiry_filename(String oneinquiry_filename) {
		this.oneinquiry_filename = oneinquiry_filename;
	}
	
	public String getOneinquiry_filetype() {
		return oneinquiry_filetype;
	}

	public void setOneinquiry_filetype(String oneinquiry_filetype) {
		this.oneinquiry_filetype = oneinquiry_filetype;
	}

	public String getOneinquiry_regdate() {
		return oneinquiry_regdate;
	}

	public void setOneinquiry_regdate(String oneinquiry_regdate) {
		this.oneinquiry_regdate = oneinquiry_regdate;
	}

	public String getOneinquiry_status() {
		return oneinquiry_status;
	}

	public void setOneinquiry_reply(String oneinquiry_status) {
		this.oneinquiry_status = oneinquiry_status;
	}

	public MultipartFile getOneinquiry_file() {
		return oneinquiry_file;
	}

	public void setOneinquiry_file(MultipartFile oneinquiry_file) {
		this.oneinquiry_file = oneinquiry_file;
	}
	
	
}

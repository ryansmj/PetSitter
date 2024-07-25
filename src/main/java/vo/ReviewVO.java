package vo;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {
	private int review_idx, review_user_idx, review_sitter_idx, review_star,review_trans_idx;
	private String review_city,review_service,review_regdate,review_user_name,review_sitter_name,review_title,review_content,review_photo_name;
	
	private MultipartFile review_photo;
	
	
	
	public MultipartFile getReview_photo() {
		return review_photo;
	}
	public void setReview_photo(MultipartFile review_photo) {
		this.review_photo = review_photo;
	}
	public String getReview_photo_name() {
		return review_photo_name;
	}
	public void setReview_photo_name(String review_photo_name) {
		this.review_photo_name = review_photo_name;
	}
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public int getReview_user_idx() {
		return review_user_idx;
	}
	public void setReview_user_idx(int review_user_idx) {
		this.review_user_idx = review_user_idx;
	}
	public int getReview_sitter_idx() {
		return review_sitter_idx;
	}
	public void setReview_sitter_idx(int review_sitter_idx) {
		this.review_sitter_idx = review_sitter_idx;
	}
	public int getReview_star() {
		return review_star;
	}
	public void setReview_star(int review_star) {
		this.review_star = review_star;
	}
	public int getReview_trans_idx() {
		return review_trans_idx;
	}
	public void setReview_trans_idx(int review_trans_idx) {
		this.review_trans_idx = review_trans_idx;
	}
	public String getReview_city() {
		return review_city;
	}
	public void setReview_city(String review_city) {
		this.review_city = review_city;
	}
	public String getReview_service() {
		return review_service;
	}
	public void setReview_service(String review_service) {
		this.review_service = review_service;
	}
	public String getReview_regdate() {
		return review_regdate;
	}
	public void setReview_regdate(String review_regdate) {
		this.review_regdate = review_regdate;
	}
	public String getReview_user_name() {
		return review_user_name;
	}
	public void setReview_user_name(String review_user_name) {
		this.review_user_name = review_user_name;
	}
	public String getReview_sitter_name() {
		return review_sitter_name;
	}
	public void setReview_sitter_name(String review_sitter_name) {
		this.review_sitter_name = review_sitter_name;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	
	
	
	
	
	
}

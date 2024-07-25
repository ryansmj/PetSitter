package vo;

public class PaymentVO {
    private int payment_idx, payment_reserve_idx, payment_user_idx, payment_sitter_idx, payment_amount;
    private String payment_user_name, payment_sitter_name, payment_uid, payment_method, payment_status, payment_date;
    
    
	
	public String getPayment_date() {
		return payment_date;
	}
	public void setPayment_date(String payment_date) {
		this.payment_date = payment_date;
	}
	public String getPayment_status() {
		return payment_status;
	}
	public void setPayment_status(String payment_status) {
		this.payment_status = payment_status;
	}
	public int getPayment_idx() {
		return payment_idx;
	}
	public void setPayment_idx(int payment_idx) {
		this.payment_idx = payment_idx;
	}
	public int getPayment_reserve_idx() {
		return payment_reserve_idx;
	}
	public void setPayment_reserve_idx(int payment_reserve_idx) {
		this.payment_reserve_idx = payment_reserve_idx;
	}
	public int getPayment_user_idx() {
		return payment_user_idx;
	}
	public void setPayment_user_idx(int payment_user_idx) {
		this.payment_user_idx = payment_user_idx;
	}
	public int getPayment_sitter_idx() {
		return payment_sitter_idx;
	}
	public void setPayment_sitter_idx(int payment_sitter_idx) {
		this.payment_sitter_idx = payment_sitter_idx;
	}
	public int getPayment_amount() {
		return payment_amount;
	}
	public void setPayment_amount(int payment_amount) {
		this.payment_amount = payment_amount;
	}
	public String getPayment_user_name() {
		return payment_user_name;
	}
	public void setPayment_user_name(String payment_user_name) {
		this.payment_user_name = payment_user_name;
	}
	public String getPayment_sitter_name() {
		return payment_sitter_name;
	}
	public void setPayment_sitter_name(String payment_sitter_name) {
		this.payment_sitter_name = payment_sitter_name;
	}
	public String getPayment_uid() {
		return payment_uid;
	}
	public void setPayment_uid(String payment_uid) {
		this.payment_uid = payment_uid;
	}
	public String getPayment_method() {
		return payment_method;
	}
	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}
}

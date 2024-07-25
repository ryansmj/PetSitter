package vo;

public class SitterApprovalVO {
   private int sitter_idx, user_idx;
   private String sitterApproval_status, sitterApproval_reason, sitterApproval_regdate;
   
   public int getSitter_idx() {
      return sitter_idx;
   }
   public void setSitter_idx(int sitter_idx) {
      this.sitter_idx = sitter_idx;
   }
   public int getUser_idx() {
      return user_idx;
   }
   public void setUser_idx(int user_idx) {
      this.user_idx = user_idx;
   }
   public String getSitterApproval_status() {
      return sitterApproval_status;
   }
   public void setSitterApproval_status(String sitterApproval_status) {
      this.sitterApproval_status = sitterApproval_status;
   }
   public String getSitterApproval_reason() {
      return sitterApproval_reason;
   }
   public void setSitterApproval_reason(String sitterApproval_reason) {
      this.sitterApproval_reason = sitterApproval_reason;
   }
   public String getSitterApproval_regdate() {
      return sitterApproval_regdate;
   }
   public void setSitterApproval_regdate(String sitterApproval_regdate) {
      this.sitterApproval_regdate = sitterApproval_regdate;
   }
}

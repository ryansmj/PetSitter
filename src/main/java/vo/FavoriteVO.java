package vo;

public class FavoriteVO {
	private int favorite_idx, favorite_user_idx, favorite_sitter_idx;
	private String favorite_regdate;
	
	
	public int getFavorite_idx() {
		return favorite_idx;
	}
	public void setFavorite_idx(int favorite_idx) {
		this.favorite_idx = favorite_idx;
	}
	public int getFavorite_user_idx() {
		return favorite_user_idx;
	}
	public void setFavorite_user_idx(int favorite_user_idx) {
		this.favorite_user_idx = favorite_user_idx;
	}
	public int getFavorite_sitter_idx() {
		return favorite_sitter_idx;
	}
	public void setFavorite_sitter_idx(int favorite_sitter_idx) {
		this.favorite_sitter_idx = favorite_sitter_idx;
	}
	public String getFavorite_regdate() {
		return favorite_regdate;
	}
	public void setFavorite_regdate(String favorite_regdate) {
		this.favorite_regdate = favorite_regdate;
	}
	
}

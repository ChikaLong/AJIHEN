require 'rails_helper'

RSpec.describe "Tags", type: :system do
  describe "GET /index" do
    it "returns http success" do
      get "/tags/index"
      expect(response).to have_http_status(:success)
    end
  end
end

# タグの表示確認
# タグ一覧と表示される
# タグ絞り込みのリンクが表示される

# タグ新規登録画面のテスト
# 新規タグ追加と表示される
# タグ追加フォームが表示される
# 追加に成功
# 追加に失敗

# 編集画面のテスト
# タグ編集と表示される
# タグ編集フォームが表示
# フォームにタグ名が表示
# 編集に成功
# 編集に失敗

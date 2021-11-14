require 'rails_helper'

RSpec.describe "Categories", type: :system do
  describe "GET /index" do
    it "returns http success" do
      get "/categories/index"
      expect(response).to have_http_status(:success)
    end
  end
end

# カテゴリの表示確認
# カテゴリ一覧と表示される
# カテゴリ絞り込みのリンクが表示される

# カテゴリ新規登録画面のテスト
# 新規カテゴリ追加と表示される
# カテゴリ追加フォームが表示される
# 追加に成功
# 追加に失敗

# 編集画面のテスト
# カテゴリ編集と表示される
# カテゴリ編集フォームが表示
# フォームにカテゴリ名が表示
# 編集に成功
# 編集に失敗
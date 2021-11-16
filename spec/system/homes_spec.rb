require 'rails_helper'

RSpec.describe "Homes", type: :system do
  describe "GET /about" do
    it "returns http success" do
      get "/homes/about"
      expect(response).to have_http_status(:success)
    end
  end
end

# トップページのテスト
# アバウトページへのリンクが表示される

# 新着一覧の文言がある
# 全ての投稿を見るのリンクがある
# みんなのレビューに遷移できる

# カテゴリ一覧があるリンクが表示

# タグ一覧があるリンクが表示

# 週間ランキングと月間ランキングが表示される

# アバウトページのテスト
# 「AJIHEN」へようこその文言がある
# 未ログイン時会員登録するのリンクとみんなのレビューを見るのリンクがある
# 遷移ができる
# ログイン時みんなのレビューを見るのリンクがある
# 遷移ができる
require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe "GET /index" do
    it "returns http success" do
      get "/posts/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/posts/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/posts/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/posts/edit"
      expect(response).to have_http_status(:success)
    end
  end
end

# Post一覧画面のテスト
# 画像が表示される
# 商品名が表示される
# 星評価が表示される
# ユーザネームが表示される
# コメント数と気になる数が表示される
# 詳細画面へのリンクがある
# 詳細画面へ遷移できる

# 詳細画面のテスト
# ユーザ名が表示される
# 商品画像が表示
# 商品名が表示
# レビューが表示
# 原産国名が表示
# 購入場所が表示
# 購入時の値段が表示
# カテゴリが表示
# 投稿日が表示
# ログイン時、コメントフォームが表示
# 未ログイン時、ログイン画面へのリンク表示
# アバウトページへのリンクがある
# 気になるボタンが表示
# 投稿者のみ編集ボタンと削除ボタンが表示


# 新規登録画面のテスト
# 遷移できる
# 書くフォームが表示
# 登録できる
# 登録できない

# 編集画面のテスト
# 遷移できる
# 各フォームが表示
# 編集できる
# 編集失敗
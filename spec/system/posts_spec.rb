require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe 'レビュー関連機能のテスト' do
    let(:user){ FactoryBot.create(:user) }
    let!(:post){ build(:post, user_id: user.id) }
    let!(:category){ FactoryBot.create(:category) }

    describe '新規投稿に関するテスト' do
      context 'ページ遷移に関するテスト' do
        it 'ページ遷移ができる' do
          visit new_post_path
          expect(current_path).to eq new_post_path
        end
      end

      context '投稿のテスト' do
        before do
          visit new_user_session_path
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
          visit new_post_path
        end

        it '投稿に成功する' do
          image_path = Rails.root.join('app/assets/images/logo.png')
          attach_file '商品画像', image_path
          fill_in '商品名', with: Faker::Lorem.characters(number: 50)
          fill_in 'レビュー', with: Faker::Lorem.characters(number: 1000)
          fill_in '原産国', with: post.country
          fill_in '購入場所', with: post.place
          fill_in '購入時の値段', with: post.price
          select category.name, from: 'post[category_id]'
          find('#review_star', visible: false).set(3)
          click_button '投稿'
          expect(page).to have_content 'レビューを投稿しました'
        end
      end
    end
  end
end

# 新規登録画面のテスト
# 遷移できる
# 登録できる
# 登録できない

# 編集画面のテスト
# 遷移できる
# 各フォームに内容が表示
# 編集できる
# 編集失敗

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


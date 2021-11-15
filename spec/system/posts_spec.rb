require 'rails_helper'

RSpec.describe "Posts", type: :system do
  describe 'レビュー関連機能のテスト' do
    let(:user){FactoryBot.create(:user)}
    let!(:post){ build(:post, user_id: user.id) }

    describe '新規投稿に関するテスト' do
      context 'ページ遷移に関するテスト' do
        it 'ページ遷移ができる' do
          visit new_post_path
          expect(current_path).to eq new_post_path
        end
      end

      # context '投稿のテスト' do
      #   before do
      #     visit new_post_path
      #   end

      #   it '投稿に成功する' do
      #     fill_in '商品画像', with: post.image
      #     fill_in '商品名', with: post.item_name
      #     fill_in 'レビュー', with: post.review
      #     fill_in '原産国', with: post.country
      #     fill_in '購入場所', with: post.place
      #     fill_in '購入時の値段', with: post.price
      #     fill_in 'カテゴリ', with: post.category_id
      #     fill_in '総合評価', with: post.rate
      #     click_button '投稿'
      #     expect(current_path).to eq post_path(post)
      #   end

      #   it '投稿に失敗する' do
      #     fill_in '商品画像', with: ""
      #     fill_in '商品名', with: ""
      #     fill_in 'レビュー', with: ""
      #     fill_in '原産国', with: ""
      #     fill_in '購入場所', with: ""
      #     fill_in '購入時の値段', with: ""
      #     fill_in 'カテゴリ', with: ""
      #     fill_in '総合評価', with: ""
      #     click_button '投稿'
      #     expect(page).to have_content "<%= post.errors.count %>件のエラーです"
      #     expect(current_path).to eq posts_path
      #   end
      # end
    end

    describe 'レビュー一覧画面のテスト' do
      before do
        visit posts_path
      end

      context '表示の確認' do
        it '商品画像が表示されている' do
          expect(page).to have_content post.image_id
        end

        it '商品名が表示されている' do
          expect(page).to have_content post.item_name
        end

        it 'レビュー内容が表示されている' do
          expect(page).to have_content post.review
        end

        it '総合評価が表示されている' do
          expect(page).to have_content post.rate
        end

        it '投稿したユーザネームが表示されている' do
          expect(page).to have_content post.user.name
        end

        it 'コメント数が表示されている' do
          expect(page).to have_content post.comments.count
        end

        it '気になる！数が表示されている' do
          expect(page).to have_content post.favorites.count
        end
      end

      context 'リンクの確認' do
        it 'レビュー詳細画面へのリンクがある' do
          expect(page).to have_link post_path(post)
        end

        it '詳細画面へ遷移できる' do
          visit post_path(post)
          expect(current_path).to eq post_path(post)
        end
      end
    end

  end
end

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


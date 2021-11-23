require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログイン前のナビのテスト' do
    context '表示の確認' do
      before do
        visit root_path
      end

      it 'ヘッダーのロゴのリンクが正しい' do
        click_link 'AJIHEN'
        expect(current_path).to eq root_path
      end

      it 'TOPと表示されており、リンク先が正しい' do
        expect(page).to have_link 'TOP', href: root_path
      end

      it '「AJIHEN」とはと表示されており、リンク先が正しい' do
        expect(page).to have_link '「AJIHEN」とは', href: about_path
      end

      it 'みんなの投稿と表示されており、リンク先が正しい' do
        expect(page).to have_link 'みんなの投稿', href: posts_path
      end

      it 'カテゴリ一覧と表示されており、リンク先が正しい' do
        expect(page).to have_link 'カテゴリ一覧', href: categories_path
      end

      it 'タグ一覧と表示されており、リンク先が正しい' do
        expect(page).to have_link 'タグ一覧', href: tags_path
      end

      it '新規登録と表示されており、リンク先が正しい' do
        expect(page).to have_link '新規登録', href: new_user_registration_path
      end

      it 'ログインと表示されており、リンク先が正しい' do
        expect(page).to have_link 'ログイン', href: new_user_session_path
      end
    end
  end

  describe 'ログイン後のナビのテスト' do
    context '表示の確認' do
      let(:user) { FactoryBot.create(:user) }

      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      it '新規登録のリンクが表示されない' do
        expect(page).to have_no_link '新規登録'
      end

      it 'ログインのリンクが表示されない' do
        expect(page).to have_no_link 'ログイン'
      end

      it 'ユーザ名が表示される' do
        expect(page).to have_content user.name
      end

      it 'マイページへのリンクがあり、リンク先が正しい' do
        expect(page).to have_link 'マイページ', href: user_path(user)
      end

      it '通知画面へのリンクがあり、リンク先が正しい' do
        expect(page).to have_link '通知', href: notifications_path
      end

      it '登録情報編集へのリンクがあり、リンク先が正しい' do
        expect(page).to have_link '登録情報編集', href: edit_user_registration_path(user)
      end

      it 'ログアウトのリンクがあり、リンク先が正しい' do
        expect(page).to have_link 'ログアウト', href: destroy_user_session_path
      end

      it '退会のリンクがあり、リンク先が正しい' do
        expect(page).to have_link '退会する', href: confirm_path
      end
    end
  end
end

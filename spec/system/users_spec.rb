require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user){FactoryBot.create(:user)}

  describe 'ユーザー認証のテスト' do
    describe 'ユーザー新規登録' do
      before do
        visit new_user_registration_path
      end
      context '新規登録画面に遷移' do
        it '新規登録に成功する' do
          fill_in 'ニックネーム', with: "テスト"
          fill_in 'メールアドレス', with: "test@example.com"
          fill_in 'パスワード', with: "123456"
          fill_in 'パスワード(確認用)', with: "123456"
          click_button '新規登録'
          expect(page).to have_content 'アカウント登録が完了しました'
        end

        it '新規登録に失敗する' do
          fill_in 'ニックネーム', with: ""
          fill_in 'メールアドレス', with: ""
          fill_in 'パスワード', with: ""
          fill_in 'パスワード(確認用)', with: ""
          click_button '新規登録'
          expect(page).to have_content '4 件のエラーが発生したため ユーザー は保存されませんでした'
        end
      end
    end

    describe 'ユーザーログインのテスト' do
      before do
        visit new_user_session_path
      end

      context 'ログイン画面に遷移' do
        it 'ログインに成功しマイページに遷移する' do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
          expect(current_path).to eq user_path(user)
        end

        it 'ログインに失敗する' do
          fill_in 'メールアドレス', with: ""
          fill_in 'パスワード', with: ""
          click_button 'ログイン'
          expect(current_path).to eq new_user_session_path
        end
      end
    end
  end

  describe 'ユーザー関連機能のテスト' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    describe 'マイページのテスト' do
      it '画面にマイページと表示される' do
        expect(page).to have_content('マイページ')
      end

      it 'ニックネームが表示される' do
        expect(page).to have_content user.name
      end

      it 'マイ気になる！のリンクが表示される' do
        expect(page).to have_content('マイ気になる！')
      end

      it 'コメントしたレビューのリンクが表示される' do
        expect(page).to have_content('コメントしたレビュー')
      end

      it '通知のリンクが表示される' do
        expect(page).to have_content('通知')
      end

      it 'コメントしたレビューのリンクが表示される' do
        expect(page).to have_content('コメントしたレビュー')
      end

      it 'プロフィール編集のリンクが表示される' do
        expect(page).to have_content('プロフィール編集')
      end

      it 'レビューを書くのリンクが表示される' do
        expect(page).to have_content('レビューを書く')
      end
    end

    describe 'マイ気になる！のテスト' do
      context 'マイ気になる！画面へ遷移' do
        it 'ページ遷移ができる' do
          visit favorites_user_path(user)
          expect(current_path).to eq favorites_user_path(user)
        end
      end

      context '表示の確認' do
        before do
          visit favorites_user_path(user)
        end

        it 'マイ気になる！と表示される' do
          expect(page).to have_content('マイ気になる！')
        end
      end
    end

    describe 'コメントしたレビューのテスト' do
      context 'コメントしたレビュー画面へ遷移' do
        it 'ページ遷移ができる' do
          visit comments_user_path(user)
          expect(current_path).to eq comments_user_path(user)
        end
      end

      context '表示の確認' do
        before do
          visit comments_user_path(user)
        end

        it 'マイ気になる！と表示される' do
          expect(page).to have_content('コメントしたレビュー')
        end
      end
    end

    describe '通知のテスト' do
      context '通知画面へ遷移' do
        it 'ページ遷移ができる' do
          visit notifications_path
          expect(current_path).to eq notifications_path
        end
      end

      context '表示の確認' do
        before do
          visit notifications_path
        end

        it '通知と表示される' do
          expect(page).to have_content('通知')
        end

        it '通知を全て削除するボタンが表示される' do
          expect(page).to have_content('通知を全て削除する')
        end
      end
    end

    describe 'プロフィール編集のテスト' do
      context 'プロフィール編集画面へ遷移' do
        it 'ページ遷移ができる' do
          visit edit_user_path(user)
          expect(current_path).to eq edit_user_path(user)
        end
      end

      context '表示の確認と編集のテスト' do
        before do
          visit edit_user_path(user)
        end

        it 'プロフィール編集と表示される' do
          expect(page).to have_content('プロフィール編集')
        end

        it 'プロフィール画像編集フォームが表示される' do
          expect(page).to have_field 'user[profile_image]'
        end

        it 'ニックネーム編集フォームに自分のニックネームが表示される' do
          expect(page).to have_field 'ニックネーム', with: user.name
        end

        it 'プロフィール編集フォームが表示される' do
          expect(page).to have_field 'user[profile]'
        end

        it 'プロフィール編集に成功する' do
          fill_in 'ニックネーム', with: "test"
          click_button '更新'
          expect(page).to have_content 'プロフィールを更新しました'
          expect(page).to have_content 'test'
          expect(current_path).to eq user_path(user)
        end

        it 'プロフィール編集に失敗する' do
          fill_in 'ニックネーム', with: ""
          click_button '更新'
          expect(page).to have_content 'プロフィール更新に失敗しました'
          expect(page).to have_content 'ニックネームが入力されていません'
          expect(current_path).to eq user_path(user)
        end
      end
    end

    describe 'アカウント登録情報編集のテスト' do
      context 'アカウント登録情報編集画面へ遷移' do
        it 'ページ遷移ができる' do
          visit edit_user_registration_path(user)
          expect(current_path).to eq edit_user_registration_path(user)
        end
      end

      context '表示の確認と編集のテスト' do
        before do
          visit edit_user_registration_path(user)
        end

        it 'アカウント登録情報編集と表示される' do
          expect(page).to have_content('アカウント登録情報編集')
        end

        it 'メールアドレス編集フォームに現在登録されているメールアドレスが表示される' do
          expect(page).to have_field 'メールアドレス', with: user.email
        end

        it 'パスワード変更フォームが表示される' do
          expect(page).to have_field 'user[password]'
        end

        it 'パスワード変更 (確認)フォームが表示される' do
          expect(page).to have_field 'user[password_confirmation]'
        end

        it '現在のパスワードが表示される' do
          expect(page).to have_field 'user[current_password]'
        end

        it '編集に成功する' do
          fill_in 'メールアドレス', with: 'test2@example.com'
          fill_in '現在のパスワード', with: user.password
          click_button '更新'
          expect(page).to have_content '登録情報を変更しました'
          expect(current_path).to eq user_path(user)
        end

        it '編集に失敗する' do
          fill_in 'メールアドレス', with: ''
          fill_in '現在のパスワード', with: ''
          click_button '更新'
          expect(page).to have_content '2 件のエラーが発生したため ユーザー は保存されませんでした'
          expect(current_path).to eq users_path
        end
      end
    end

    describe '退会のテスト' do
      context '退会確認画面へ遷移のテスト' do
        it 'ページ遷移ができる' do
          visit confirm_path
          expect(current_path).to eq confirm_path
        end
      end

      context '表示の確認' do
        before do
          visit confirm_path
        end

        it '退会確認と表示される' do
          expect(page).to have_content('退会確認')
        end

        it 'マイページに戻るボタンが表示される' do
          expect(page).to have_content('マイページに戻る')
        end

        it 'マイページに戻ることができる' do
          click_link 'マイページに戻る'
          expect(current_path).to eq user_path(user)
        end

        it '退会するボタンが表示される' do
          expect(page).to have_content('退会する')
        end

        it '退会確認用のモーダルが存在する' do
          expect(page).to have_selector('.modal', visible: false)
        end

        it 'モーダルが出力される' do
          expect( find('.modal', visible: false) ).to have_selector('.modal-title', text: '退会確認')
        end
      end
    end

    describe 'ログアウトのテスト' do
      before do
        click_link 'ログアウト'
      end

      context 'ログアウト機能' do
        it 'ログアウト後、新規登録とログインのリンクが表示される' do
          expect(page).to have_content('新規登録')
          expect(page).to have_content('ログイン')
        end

        it 'ログアウト後のリンク先がTOPページになっている' do
          expect(current_path).to eq '/'
        end
      end
    end
  end

  describe '管理者側のテスト' do
    let!(:user){ FactoryBot.create(:user, admin: true) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    context '管理者に表示されるボタンのテスト' do
      it '全登録ユーザボタンが表示される' do
        expect(page).to have_content('全登録ユーザ')
      end
      
      it '新規タグ追加ボタンが表示される' do
        expect(page).to have_content('新規タグ追加')
      end
      
      it '新規カテゴリ追加ボタンが表示される' do
        expect(page).to have_content('新規カテゴリ追加')
      end
    end
    
    describe '全登録ユーザ一覧のテスト' do
      context '遷移のテスト' do
        it 'ページ遷移ができる' do
          visit users_path
          expect(current_path).to eq users_path
        end
      end
      
      context '表示とリンクのテスト' do
        before do
          visit users_path
        end
        
        it '登録ユーザ一覧と表示される' do
          expect(page).to have_content('登録ユーザ一覧')
        end
        
        it 'ユーザ名とメールアドレスが表示される' do
          expect(page).to have_content user.name
          expect(page).to have_content user.email
        end
        
        it '退会させるボタンがある' do
          expect(page).to have_content('退会させる')
        end
      end
      
    end
  end
end


# 正しく退会できるかのテスト

# ※以下管理者のみ
# 全登録ユーザへのリンクがある
# 新規タグ追加のリンクがある
# 新規カテゴリ追加のリンクがある

# 全登録ユーザ画面のテスト
# 全登録ユーザ画面へ遷移する
# 管理者以外に退会ボタンが表示される

# 新規タグ追加のテスト
# 新規タグ追加画面へ遷移する

# 新規カテゴリ追加のテスト
# 新規カテゴリ追加の画面へ遷移する

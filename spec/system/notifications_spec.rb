require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  describe '通知機能のテスト' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    let(:comment) { FactoryBot.create(:comment) }
    let!(:notification) { build(:notification, post_id: post.id) }

    describe '通知画面のテスト' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

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

    describe '通知のテスト' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit post_path(post)
      end

      it 'コメントが投稿されると通知が保存される' do
        fill_in 'comment[comment]', with: comment.comment
        click_button 'コメントする'
        expect(notification).to be_valid
      end
    end
  end
end

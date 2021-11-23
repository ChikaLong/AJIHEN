require 'rails_helper'

RSpec.describe "Favorites", :type => :system do
  describe '気になる！（いいね機能）のテスト' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    let!(:favorite) { build(:favorite, user_id: user.id, post_id: post.id) }

    describe '気になる！ボタンのテスト' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit post_path(post)
      end

      context '気になる？をクリックする', js: true do
        it '気になる！ができる' do
          find('.btn-outline-warning').click
          expect(page).to have_selector '.btn-warning'
          expect(post.favorites.count).to eq(1)
        end
      end

      context '気になる！をクリックする', js: true do
        it '気になる？に戻せる' do
          find('.btn-outline-warning').click
          find('.btn-warning').click
          expect(page).to have_selector '.btn-outline-warning'
          expect(post.favorites.count).to eq(0)
        end
      end
    end
  end
end

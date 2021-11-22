require 'rails_helper'

RSpec.describe "Homes", type: :system do
  let!(:category){ FactoryBot.create(:category) }
  let!(:tag){ FactoryBot.create(:tag)}

  describe 'トップページのテスト' do
    before do
      visit root_path
    end

    context '表示の確認' do
      it '「AJIHEN」とはへのリンクがあり、リンク先が正しい' do
        expect(page).to have_link 'こちら', href: about_path
      end

      it '新着投稿と表示される' do
        expect(page).to have_content('新着投稿')
      end

      it '全ての投稿を見るの表示があり、リンク先が正しい' do
        expect(page).to have_link '全ての投稿を見る', href: posts_path
      end

      it 'カテゴリ一覧と表示される' do
        expect(page).to have_content('カテゴリ一覧')
      end

      it 'カテゴリ名が表示され、絞り込みのリンク先が正しい' do
        expect(page).to have_link category.name, href: category_search_path(category_id: category.id)
      end

      it 'タグ一覧と表示される' do
        expect(page).to have_content('タグ一覧')
      end

      it 'タグ名が表示され、絞り込みのリンク先が正しい' do
        expect(page).to have_link tag.name, href: tag_search_path(tag_id: tag.id)
      end

      it '週間気になる！TOP3と表示される' do
        expect(page).to have_content('週間気になる！TOP3')
      end

      it '月間気になる！TOP3と表示される' do
        expect(page).to have_content('月間気になる！TOP3')
      end
    end
  end

  describe 'アバウトページのテスト' do
    context '表示の確認：ログイン前' do
      before do
        visit about_path
      end

      it '「AJIHENへようこそ」と表示される' do
        expect(page).to have_content('AJIHENへようこそ')
      end

      it '会員登録するの表示があり、リンク先が正しい' do
        expect(page).to have_link '会員登録する', href: new_user_registration_path
      end

      it 'みんなの投稿を見るの表示があり、リンク先が正しい' do
        expect(page).to have_link 'みんなの投稿を見る', href: posts_path
      end
    end

    context '表示の確認：ログイン後' do
      let(:user){ FactoryBot.create(:user) }

      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit about_path
      end

      it '会員登録をするが表示されなくなる' do
        expect(page).to have_no_link '会員登録する'
      end

      it 'みんなの投稿を見るの表示があり、リンク先が正しい' do
        expect(page).to have_link 'みんなの投稿を見る', href: posts_path
      end
    end
  end
end

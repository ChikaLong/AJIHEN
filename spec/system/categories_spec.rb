require 'rails_helper'

RSpec.describe "Categories", type: :system do
  describe 'カテゴリ関連のテスト' do
    let!(:category) { FactoryBot.create(:category) }

    describe 'カテゴリ一覧画面のテスト' do
      it '遷移ができる' do
        visit categories_path
        expect(current_path).to eq categories_path
      end

      context '表示に関するテスト(admin以外)' do
        before do
          visit categories_path
        end

        it 'カテゴリ一覧と表示される' do
          expect(page).to have_content('カテゴリ一覧')
        end

        it 'カテゴリ名が表示されている' do
          expect(page).to have_content category.name
        end

        it 'カテゴリを絞り込みのリンクが正しい' do
          expect(page).to have_link category.name, href: category_search_path(category_id: category.id)
        end
      end

      context '表示に関するテスト(admin)' do
        let!(:user) { FactoryBot.create(:user, admin: true) }

        before do
          visit new_user_session_path
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
        end

        it 'カテゴリ編集へのリンク先が正しい' do
          visit categories_path
          expect(page).to have_link '編集', href: edit_category_path(category)
        end
      end
    end

    describe '新規登録に関するテスト' do
      let!(:user) { FactoryBot.create(:user, admin: true) }

      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      context '遷移に関するテスト' do
        it 'ページ遷移ができる' do
          visit new_category_path
          expect(current_path).to eq new_category_path
        end
      end

      context '表示に関するテスト' do
        before do
          visit new_category_path
        end

        it '新規カテゴリ追加と表示される' do
          expect(page).to have_content('カテゴリの新規登録')
        end

        it '現在登録されているカテゴリが表示される' do
          expect(page).to have_content('現在登録されているカテゴリ')
          expect(page).to have_content category.name
        end
      end

      context '新規登録に関するテスト' do
        before do
          visit new_category_path
        end

        it 'カテゴリの登録に成功する' do
          fill_in 'category[name]', with: category.name
          click_button '新規追加'
          expect(page).to have_content('新規カテゴリを登録しました')
        end

        it '新規カテゴリの登録に失敗する' do
          fill_in 'category[name]', with: ""
          click_button '新規追加'
          expect(page).to have_content('カテゴリの登録に失敗しました')
        end
      end
    end

    describe 'カテゴリ編集のテスト' do
      let!(:user) { FactoryBot.create(:user, admin: true) }

      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      context '遷移のテスト' do
        it 'ページ遷移ができる' do
          visit edit_category_path(category)
          expect(current_path).to eq edit_category_path(category)
        end
      end

      context '表示と編集のテスト' do
        before do
          visit edit_category_path(category)
        end

        it 'カテゴリの編集と表示される' do
          expect(page).to have_content('カテゴリの編集')
        end

        it '編集フォームにカテゴリ名が表示されている' do
          expect(page).to have_field 'category[name]', with: category.name
        end

        it '現在登録されているカテゴリが表示される' do
          expect(page).to have_content('現在登録されているカテゴリ')
          expect(page).to have_content category.name
        end

        it '編集に成功する' do
          fill_in 'category[name]', with: category.name
          click_button '更新'
          expect(page).to have_content('カテゴリを編集しました')
        end

        it '編集に失敗する' do
          fill_in 'category[name]', with: ""
          click_button '更新'
          expect(page).to have_content('カテゴリの編集に失敗しました')
        end
      end
    end
  end
end

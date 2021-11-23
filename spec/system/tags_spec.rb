require 'rails_helper'

RSpec.describe "Tags", type: :system do
  describe 'タグ関連のテスト' do
    let!(:tag) { FactoryBot.create(:tag) }

    describe 'タグ一覧画面のテスト' do
      it '遷移ができる' do
        visit tags_path
        expect(current_path).to eq tags_path
      end

      context '表示に関するテスト(admin以外)' do
        before do
          visit tags_path
        end

        it 'タグ一覧と表示される' do
          expect(page).to have_content('タグ一覧')
        end

        it 'タグ名が表示されている' do
          expect(page).to have_content tag.name
        end

        it 'タグを絞り込みのリンクが正しい' do
          expect(page).to have_link tag.name, href: tag_search_path(tag_id: tag.id)
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

        it 'タグ編集へのリンク先が正しい' do
          visit tags_path
          expect(page).to have_link '編集', href: edit_tag_path(tag)
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
          visit new_tag_path
          expect(current_path).to eq new_tag_path
        end
      end

      context '表示に関するテスト' do
        before do
          visit new_tag_path
        end

        it '新規タグ追加と表示される' do
          expect(page).to have_content('タグの新規登録')
        end

        it '現在登録されているタグが表示される' do
          expect(page).to have_content('現在登録されているタグ')
          expect(page).to have_content tag.name
        end
      end

      context '新規登録に関するテスト' do
        before do
          visit new_tag_path
        end

        it 'タグの登録に成功する' do
          fill_in 'tag[name]', with: tag.name
          click_button '新規追加'
          expect(page).to have_content('新規タグを登録しました')
        end

        it '新規タグの登録に失敗する' do
          fill_in 'tag[name]', with: ""
          click_button '新規追加'
          expect(page).to have_content('タグの登録に失敗しました')
        end
      end
    end

    describe 'タグ編集のテスト' do
      let!(:user) { FactoryBot.create(:user, admin: true) }

      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      context '遷移のテスト' do
        it 'ページ遷移ができる' do
          visit edit_tag_path(tag)
          expect(current_path).to eq edit_tag_path(tag)
        end
      end

      context '表示と編集のテスト' do
        before do
          visit edit_tag_path(tag)
        end

        it 'タグの編集と表示される' do
          expect(page).to have_content('タグの編集')
        end

        it '編集フォームにタグ名が表示されている' do
          expect(page).to have_field 'tag[name]', with: tag.name
        end

        it '現在登録されているタグが表示される' do
          expect(page).to have_content('現在登録されているタグ')
          expect(page).to have_content tag.name
        end

        it '編集に成功する' do
          fill_in 'tag[name]', with: tag.name
          click_button '更新'
          expect(page).to have_content('タグを編集しました')
        end

        it '編集に失敗する' do
          fill_in 'tag[name]', with: ""
          click_button '更新'
          expect(page).to have_content('タグの編集に失敗しました')
        end
      end
    end
  end
end

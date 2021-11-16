require 'rails_helper'

RSpec.describe "Contacts", type: :system do
  describe 'お問い合わせフォームのテスト' do
    let(:contact){ FactoryBot.create(:contact) }

    describe '遷移のテスト' do
      it '問い合わせフォームに遷移できる' do
        visit new_contact_path
        expect(current_path).to eq new_contact_path
      end

      it '遷移後お問い合わせ・ご要望フォームと表示されている' do
        visit new_contact_path
        expect(page).to have_content('お問い合わせ・ご要望フォーム')
      end
    end

    describe '入力のテスト' do
      before do
        visit new_contact_path
      end

      context '入力の保存ができるかのテスト' do
        it '入力の保存に成功し確認画面へ遷移' do
          fill_in 'お名前', with: Faker::Lorem.characters(number: 20)
          fill_in 'メールアドレス', with: Faker::Internet.email
          fill_in '件名', with: Faker::Lorem.characters(number: 50)
          fill_in 'お問い合わせ・ご要望', with: Faker::Lorem.characters(number: 500)
          click_button '入力内容確認'
          expect(current_path).to eq confirm_contacts_path
        end

        it '入力の保存に失敗する' do
          fill_in 'お名前', with: ""
          fill_in 'メールアドレス', with: ""
          fill_in '件名', with: ""
          fill_in 'お問い合わせ・ご要望', with: ""
          click_button '入力内容確認'
          expect(page).to have_content "正しく入力してください"
        end
      end
    end
  end
end




# 入力確認画面のテスト
# 入力確認画面と表示される
# 入力内容が表示される

# 入力画面に戻るボタンが表示される
# 送信ボタンが表示される

# 送信される

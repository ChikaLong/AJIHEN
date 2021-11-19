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

    describe '入力確認画面のテスト' do
      before do
        visit new_contact_path
        fill_in 'お名前', with: "test"
        fill_in 'メールアドレス', with: "test@example.com"
        fill_in '件名', with: "問い合わせ"
        fill_in 'お問い合わせ・ご要望', with: "sample_message"
        click_button '入力内容確認'
      end

      context '表示の確認' do
        it '入力内容確認と表示されている' do
          expect(page).to have_content('入力内容確認')
        end

        it 'お名前が表示されている' do
          expect(page).to have_content "test"
        end

        it 'メールアドレスが表示されている' do
          expect(page).to have_content "test@example.com"
        end

        it '件名が表示されている' do
          expect(page).to have_content "問い合わせ"
        end

        it 'お問い合わせ・ご要望が表示されている' do
          expect(page).to have_content "sample_message"
        end

        it '入力画面に戻るボタンが表示されている' do
          expect(page).to have_button '入力画面に戻る'
        end

        it '送信ボタンが表示されている' do
          expect(page).to have_button '送信'
        end
      end

      context '入力画面に戻った時のテスト' do
        before do
          click_button '入力画面に戻る'
        end

        it 'フォームに名前が表示されている' do
          expect(page).to have_field 'お名前', with: "test"
        end

        it 'フォームにメールアドレスが表示されている' do
          expect(page).to have_field 'メールアドレス', with: "test@example.com"
        end

        it 'フォームに件名が表示されている' do
          expect(page).to have_field '件名', with: "問い合わせ"
        end

        it 'フォームに問い合わせ・要望内容が表示されている' do
          expect(page).to have_field 'お問い合わせ・ご要望', with: "sample_message"
        end
      end

      context '送信の確認' do
        it '送信ボタンを押すと送信完了画面へ遷移する' do
          click_button '送信'
          expect(current_path).to eq complete_contacts_path
        end
      end
    end
  end
end

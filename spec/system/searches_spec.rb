require 'rails_helper'

RSpec.describe "Searches", type: :system do
  describe "検索機能のテスト" do
    let(:user){ FactoryBot.create(:user) }
    let!(:post){ FactoryBot.create(:post) }
    let!(:tag){ FactoryBot.create(:tag)}
    let!(:category){ FactoryBot.create(:category) }

    describe 'キーワド検索のテスト' do
      before do
        visit root_path
      end

      context 'キーワドを入力した場合' do
        it 'キーワードに当てはまる投稿を検索できる' do
          fill_in 'keyword', with: "word"
          find('.btn-outline-secondary').click
          expect(page).to have_content("word")
        end
      end

      context 'キーワドを入力しなかった場合' do
        it '全ての投稿が表示される' do
          fill_in 'keyword', with: ""
          find('.btn-outline-secondary').click
          expect(page).to have_content("全ての投稿")
        end
      end
    end

    describe 'タグ検索のテスト' do
      before do
        visit tags_path
      end

      it 'タグをクリックするとタグ検索結果に遷移する' do
        click_link tag.name
        expect(current_path).to eq tag_search_path
      end
    end

    describe 'カテゴリ検索のテスト' do
      before do
        visit categories_path
      end

      it 'カテゴリをクリックするとカテゴリ検索結果に遷移する' do
        click_link category.name, match: :first
        expect(current_path).to eq category_search_path
      end
    end
  end
end
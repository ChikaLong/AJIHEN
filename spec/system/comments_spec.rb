require 'rails_helper'

RSpec.describe "Comments", type: :system do
  describe 'コメント機能のテスト' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
    let!(:comment) { build(:comment, user_id: user.id, post_id: post.id) }

    describe 'コメント投稿のテスト' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit post_path(post)
      end

      context 'コメントが保存できる' do
        it 'コメントの保存に成功する' do
          fill_in 'comment[comment]', with: comment.comment
          click_button 'コメントする'
          expect(page).to have_content comment.user.name
          expect(page).to have_content comment.comment
        end
      end

      context 'コメントが保存できない' do
        it 'コメントの保存に失敗する' do
          fill_in 'comment[comment]', with: ""
          click_button 'コメントする'
          expect(page).to have_content "コメントが入力されていません"
        end
      end

      context '表示の確認' do
        before do
          fill_in 'comment[comment]', with: comment.comment
          click_button 'コメントする'
        end

        it '削除ボタンのアイコンが表示される' do
          expect(page).to have_selector '.fas.fa-trash-alt'
        end

        it 'コメント削除確認用のモーダルがある' do
          expect(page).to have_selector('.modal', visible: false)
        end

        it 'コメント削除確認用のモーダルが出力される' do
          expect(find('.modal', visible: false)).to have_selector('.modal-title', text: 'コメントの削除')
        end
      end

      context 'コメント削除ができる' do
        before do
          fill_in 'comment[comment]', with: comment.comment
          click_button 'コメントする'
        end

        it 'コメントの削除に成功する' do
          expect do
            find('.modal', visible: false)
            click_on "削除する"
          end.to change { Comment.count }.by(-1)
        end
      end
    end
  end
end

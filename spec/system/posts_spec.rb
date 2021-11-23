require 'rails_helper'

RSpec.describe "Posts", :type => :system do
  describe '投稿関連機能のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:post) { FactoryBot.create(:post) }
    let!(:category) { FactoryBot.create(:category) }

    describe '新規投稿に関するテスト' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      context 'ページ遷移に関するテスト' do
        it 'ページ遷移ができる' do
          visit new_post_path
          expect(current_path).to eq new_post_path
        end
      end

      context '投稿のテスト', js: true do
        before do
          visit new_post_path
        end

        it '投稿に成功する' do
          image_path = Rails.root.join('app/assets/images/logo.png')
          attach_file '商品画像', image_path
          fill_in '商品名', with: Faker::Lorem.characters(number: 50)
          fill_in 'レビュー', with: Faker::Lorem.characters(number: 1000)
          fill_in '原産国', with: post.country
          fill_in '購入場所', with: post.place
          fill_in '購入時の値段', with: post.price
          find("#post_category_id").find("option[value='1']").select_option
          find("img[alt='3']").click
          click_button '投稿'
          expect(page).to have_content '投稿に成功しました'
        end

        it '投稿に失敗する' do
          image_path = Rails.root.join('app/assets/images/logo.png')
          attach_file '商品画像', image_path
          fill_in '商品名', with: ""
          fill_in 'レビュー', with: ""
          fill_in '原産国', with: ""
          fill_in '購入場所', with: ""
          fill_in '購入時の値段', with: ""
          find("#post_category_id").find("option[value='']").select_option
          click_button '投稿'
          expect(page).to have_content '件のエラーです'
        end
      end
    end

    describe '投稿編集に関するテスト' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
        visit posts_path
      end

      context '遷移のテスト' do
        before do
          visit post_path(post)
        end

        it '編集画面に遷移できる' do
          visit edit_post_path(post)
          expect(current_path).to eq edit_post_path(post)
        end
      end

      context '表示の確認' do
        before do
          visit post_path(post)
          visit edit_post_path(post)
        end

        it '投稿編集と表示される' do
          expect(page).to have_content '投稿編集'
        end

        it '商品名フォームに商品名が表示される' do
          expect(page).to have_field '商品名', with: post.item_name
        end

        it 'レビューフォームにレビューが表示される' do
          expect(page).to have_field 'レビュー', with: post.review
        end

        it '原産国フォームに原産国が表示されている' do
          expect(page).to have_field '原産国', with: post.country
        end

        it '購入場所フォームに購入場所が表示されている' do
          expect(page).to have_field '購入場所', with: post.place
        end

        it '購入時の値段のフォームに購入時の値段が表示されている' do
          expect(page).to have_field '購入時の値段', with: post.price
        end
      end
    end

    describe '一覧画面のテスト' do
      before do
        visit posts_path
      end

      context '表示の確認' do
        it '商品名が表示されており(11文字以下)、リンク先が正しい' do
          expect(page).to have_link post.item_name, maximum: 11, href: post_path(post)
        end

        it 'オススメ度が表示されている' do
          expect(page).to have_content post.rate
        end

        it 'レビュー内容が表示されている(25文字以下)' do
          expect(page).to have_content post.review, maximum: 25
        end

        it 'ユーザ名が表示されており、リンク先が正しい' do
          expect(page).to have_link post.user.name, href: user_path(post.user)
        end

        it '投稿日が表示されている' do
          expect(page).to have_content post.created_at.strftime('%Y/%m/%d')
        end

        it 'コメント数が表示されている' do
          expect(page).to have_content post.comments.count
        end

        it '気になる！数が表示されている' do
          expect(page).to have_content post.favorites.count
        end
      end
    end

    describe '詳細画面のテスト（未ログイン時）' do
      context '表示の確認' do
        before do
          visit posts_path
          visit post_path(post)
        end

        it '投稿ユーザ名が表示されている' do
          expect(page).to have_content post.user.name
        end

        it '商品名が表示されている' do
          expect(page).to have_content post.item_name
        end

        it 'オススメ度が表示されている' do
          expect(page).to have_content post.rate
        end

        it 'レビューが表示されている' do
          expect(page).to have_content post.review
        end

        it '総合評価への目安と表示されており、リンク先が正しい' do
          expect(page).to have_link 'オススメ度の目安', href: about_path
        end

        it '原産国が表示されている' do
          expect(page).to have_content post.country
        end

        it '購入場所が表示されている' do
          expect(page).to have_content post.place
        end

        it '購入時の値段が表示されている' do
          expect(page).to have_content post.price
        end

        it 'カテゴリが表示されている' do
          expect(page).to have_content post.category.name
        end

        it '投稿日が表示されている' do
          expect(page).to have_content post.created_at.strftime('%Y/%m/%d')
        end

        it '気になる？ボタンが表示されていない' do
          expect(page).to have_no_content '気になる?'
        end

        it 'コメントフォームが表示されていない' do
          expect(page).to have_no_field 'comment[comment]'
        end
      end
    end

    describe '詳細画面のテスト（ログイン時）' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      context '表示の確認(ログイン時)' do
        before do
          visit posts_path
          visit post_path(post)
        end

        it '気になる？ボタンが表示される' do
          expect(page).to have_content '気になる？'
        end

        it 'コメントフォームが表示される' do
          expect(page).to have_field 'comment[comment]'
        end
      end

      context '表示と削除の確認（投稿者のみ）' do
        before do
          visit new_post_path
          image_path = Rails.root.join('app/assets/images/logo.png')
          attach_file '商品画像', image_path
          fill_in '商品名', with: Faker::Lorem.characters(number: 50)
          fill_in 'レビュー', with: Faker::Lorem.characters(number: 1000)
          fill_in '原産国', with: post.country
          fill_in '購入場所', with: post.place
          fill_in '購入時の値段', with: post.price
          find("#post_category_id").find("option[value='1']").select_option
          find('#review_star', visible: false).set(3)
          click_button '投稿'
        end

        it '投稿編集ボタンが表示される' do
          expect(page).to have_content '投稿を編集'
        end

        it '投稿削除ボタンが表示される' do
          expect(page).to have_content '投稿を削除'
        end

        it '削除確認用のモーダルが存在する' do
          expect(page).to have_selector('.modal', visible: false)
        end

        it 'モーダルが出力される' do
          expect(find('.modal', visible: false)).to have_selector('.modal-title', text: '投稿の削除')
        end

        it '投稿の削除ができる' do
          expect do
            find('.modal', visible: false)
            click_on "削除"
          end.to change { Post.count }.by(-1)
        end
      end
    end
  end
end

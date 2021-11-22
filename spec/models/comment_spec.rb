# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Commentモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { comment.valid? }

    let(:user) { FactoryBot.create(:user) }
    let(:post) { build(:post, user_id: user.id) }
    let!(:comment) { build(:comment, user_id: user.id, post_id: post.id) }

    context 'image_idカラム' do
      it '空欄でないこと' do
        comment.comment = ''
        is_expected.to eq false
      end
    end

    context 'commentカラム' do
      it '空欄でないこと' do
        comment.comment = ''
        is_expected.to eq false
      end
      it '500文字以下であること: 501文字不可' do
        comment.comment = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end

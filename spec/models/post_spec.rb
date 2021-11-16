# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user){FactoryBot.create(:user)}
    let!(:post){ build(:post, user_id: user.id) }

    context 'image_idカラム' do
      it '空欄でないこと' do
        post.image_id = ''
        is_expected.to eq false
      end
    end

    context 'item_nameカラム' do
      it '空欄でないこと' do
        post.item_name = ''
        is_expected.to eq false
      end
      it '50文字以下であること: 51文字不可' do
        post.item_name = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'reviewカラム' do
      it '空欄でないこと' do
        post.review = ''
        is_expected.to eq false
      end
      it '1000文字以下であること: 1001文字不可' do
        post.review = Faker::Lorem.characters(number: 1001)
        is_expected.to eq false
      end
    end

    context 'countryカラム' do
      it '空欄でないこと' do
        post.country = ''
        is_expected.to eq false
      end
    end

    context 'placeカラム' do
      it '空欄でないこと' do
        post.place = ''
        is_expected.to eq false
      end
    end

    context 'priceカラム' do
      it '空欄でないこと' do
        post.price = ''
        is_expected.to eq false
      end
    end

    context 'rateカラム' do
      it '空欄でないこと' do
        post.rate = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Categoryモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end

    context 'PostTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:post_tags).macro).to eq :has_many
      end
    end

    context 'Tagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:tags).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tagモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { tag.valid? }

    let(:tag) { FactoryBot.create(:tag) }

    context 'nameカラム' do
      it '空欄でないこと' do
        tag.name = ''
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'PostTagモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:post_tags).macro).to eq :has_many
      end
    end

    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Tag.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end

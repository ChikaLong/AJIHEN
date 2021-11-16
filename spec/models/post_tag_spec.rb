# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostTagモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Pastモデルとの関係' do
      it 'N:1となっている' do
        expect(PostTag.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Tagモデルとの関係' do
      it 'N:1となっている' do
        expect(PostTag.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
  end
end

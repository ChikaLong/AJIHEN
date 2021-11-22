# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { contact.valid? }

    let(:contact) { FactoryBot.create(:contact) }

    context 'nameカラム' do
      it '空欄でないこと' do
        contact.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は不可' do
        contact.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字可' do
        contact.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字可' do
        contact.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字不可' do
        contact.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        contact.email = ''
        is_expected.to eq false
      end
    end

    context 'subjectカラム' do
      it '空欄でないこと' do
        contact.subject = ''
        is_expected.to eq false
      end
      it '50文字以下であること: 50文字可' do
        contact.subject = Faker::Lorem.characters(number: 50)
        is_expected.to eq true
      end
      it '50文字以下であること: 51文字不可' do
        contact.subject = Faker::Lorem.characters(number: 51)
        is_expected.to eq false
      end
    end

    context 'messageカラム' do
      it '空欄でないこと' do
        contact.message = ''
        is_expected.to eq false
      end
      it '500文字以下であること: 500文字可' do
        contact.message = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '500文字以下であること: 501文字不可' do
        contact.message = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end
end

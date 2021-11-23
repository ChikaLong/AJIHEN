require 'rails_helper'

describe 'フッターのテスト' do
  before do
    visit root_path
  end

  it 'お問い合わせフォームへのリンクがあり、リンク先が正しい' do
    expect(page).to have_link 'お問い合わせ・ご要望', href: new_contact_path
  end
end

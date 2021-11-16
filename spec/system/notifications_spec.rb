require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  describe "GET /index" do
    it "returns http success" do
      get "/notifications/index"
      expect(response).to have_http_status(:success)
    end
  end
end

# 通知のテスト
# 通知がある時は通知ありになる
# 通知がない時は通知のみの表示になる
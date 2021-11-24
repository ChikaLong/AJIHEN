# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: '管理人',
  email: ENV["ADMIN_ADDRESS"],
  password: ENV["ADMIN_PASSWORD"],
  admin: true
)

User.create!(
  name: "test",
  email: "test@test.com",
  password: "123456"
)

Tag.create!(
  [
    {name: '和食に合う'},
    {name: '洋食に合う'},
    {name: '中華に合う'},
    {name: '麺に合う'},
    {name: 'パンに合う'},
    {name: 'ご飯に合う'},
    {name: '塩分控えめ'},
    {name: '辛い'},
    {name: '甘い'},
    {name: '酸味がある'},
    {name: '苦味がある'},
    {name: '味濃いめ'},
    {name: '味薄め'},
    {name: 'ニンニク'},
    {name: '多用途'},
    {name: 'コスパ◎'},
    {name: 'リピートしたい'},
    {name: '隠し味に'}
  ]
)

Category.create!(
  [
    {name: '砂糖・甘味料'},
    {name: '塩'},
    {name: '酢'},
    {name: '醤油'},
    {name: 'ポン酢'},
    {name: '味噌'},
    {name: 'たれ、つゆ'},
    {name: '出汁'},
    {name: 'スープの素'},
    {name: '酒系'},
    {name: 'ソース'},
    {name: 'ケチャップ'},
    {name: 'マヨネーズ'},
    {name: 'マスタード'},
    {name: 'ドレッシング'},
    {name: '油脂'},
    {name: '香辛料'},
    {name: '薬味'},
    {name: 'ハーブ'},
    {name: 'ふりかけ'},
    {name: '万能調味料'},
    {name: 'その他'}
  ]
)

20.times do
  Post.create!(
    user_id: 1,
    category_id: 2,
    image: File.open("#{Rails.root}/app/assets/images/logo.png"),
    item_name: "塩",
    review: "多用途で使える塩です",
    country: "日本",
    place: "スーパー",
    price: "200円",
    rate: "4.0",
    tag_ids: [15,18],
  )
end

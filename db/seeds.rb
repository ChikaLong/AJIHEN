# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: 'test2',
  email: 'test@com',
  password: '909090'
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
    {name: '隠し味に'},
    {name: 'その他'}
  ]
)

Category.create!(
  [
    {name: '砂糖'},
    {name: 'シロップ'},
    {name: '塩'},
    {name: '酢'},
    {name: '醤油'},
    {name: '味噌'},
    {name: 'たれ、つゆ'},
    {name: '出汁'},
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

30.times do |n|
  Post.create!(
    user_id: 1,
    category_id: 6,
    image: File.open("#{Rails.root}/app/assets/images/icon_gray.png"),
    item_name: "味噌",
    review: "味噌汁に",
    country: "日本",
    place: "西友",
    price: "500",
    rate: "4"
  )
end
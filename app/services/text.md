## 記事作成テスト

1記事を作成
  WpArticle.create(title: "テスト記事1",article_url: "example.com
",thumbnail_url: "example.com",published_at:Time.now,wp_id:1000)

id: 11,
 title: "テスト記事1",
 article_url: "example.com",
 thumbnail_url: "example.com",
 published_at: Thu, 20 Jun 2024 23:10:28.050592000 JST +09:00,
 is_published: true,
 created_at: Thu, 20 Jun 2024 23:10:28.103578000 JST +09:00,
 updated_at: Thu, 20 Jun 2024 23:10:28.103578000 JST +09:00,
 wp_id: 1000>

2スラッグを作成
  Slug.create(name: "テストスラッグ")

  id: 11,
  name: "テストスラッグ",
  created_at: Thu, 20 Jun 2024 23:10:46.238000000 JST +09:00,
  updated_at: Thu, 20 Jun 2024 23:10:46.238000000 JST +09:00>

3スラッグと記事の紐付け
  上で作成した記事とスラッグを紐づける
  WpArticleSlug.create(wp_article_id: 11,slug_id: 11)

  id: 11,
  wp_article_id: 11,
  slug_id: 11,
  created_at: Thu, 20 Jun 2024 23:13:59.459289000 JST +09:00,
  updated_at: Thu, 20 Jun 2024 23:13:59.459289000 JST +09:00>


タイトルをrailsコンソールから変更。再度同期ボタンを押す。タイトルが変わっているかを確認。

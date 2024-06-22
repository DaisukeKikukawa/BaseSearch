namespace :create_test_transaction_data do
  desc "ランダムな球場データを投入する"
  task insert_grounds: :environment do
    limit = 50

    limit.times do |index|
      ground_data = {
        name: "球場#{index + 1}",                # 球場名
        link_url: "",                           # 外部リンク
        administrative_organization: "",        # 管理組織
        tel: "",                                # 電話番号
        address: Faker::Address.street_address, # 住所
        image: "",                              # 画像
        google_map_url: "",                     # googlemapのURL
        access: "",                             # アクセス
        sport: "野球、バスケ",
        created_at: Time.zone.parse('2011-11-11 11:11:11'),
      }

      Ground.create!(ground_data)
    end

    puts "Ground data inserted successfully!"
  end

  desc "insert_groundsで作成したデータを削除する"
  task delete_grounds: :environment do
    Ground.where(created_at: Time.zone.parse('2011-11-11 11:11:11')).destroy_all

    puts "Ground data deleted successfully!"
  end

  desc "ランダムなチームデータを投入する"
  task insert_teams: :environment do
    limit = 10

    limit.times do |index|
      team_data = {
        name: "チーム#{index + 1}",      # チーム名
        team_category_id: 1,            # チームカテゴリ
        school_name: "学校#{index + 1}", # 学校名
        email: Faker::Internet.email,    # メールアドレス
        created_at: Time.zone.parse('2011-11-11 11:11:11'),
      }

      Team.create!(team_data)
    end

    puts "Team data inserted successfully!"
  end

  desc "insert_teamsで作成したデータを削除する"
  task delete_teams: :environment do
    Team.where(created_at: Time.zone.parse('2011-11-11 11:11:11')).destroy_all

    puts "Team data deleted successfully!"
  end

  desc "ランダムな記事データを投入する"
  task insert_articles: :environment do
    limit = 10

    limit.times do |index|
      game = Game.order("RAND()").first

      # 有効な article type を使用します
      begin
        game_article = game.game_articles.create!(article_type: :match_results)

        article_data = {
          title: "記事#{index + 1}",                        # 記事タイトル
          content: Faker::Lorem.paragraph,                  # 記事コンテンツ
          belongable_id: game_article.id,                   # GameArticleへの外部キー
          belongable_type: 'GameArticle',                   # GameArticleへの外部キー
          created_at: Time.zone.parse('2011-11-11 11:11:11'),
        }

        Article.create!(article_data)
      rescue ActiveRecord::RecordInvalid => e
        puts "Validation error: #{e.message}. Skipping to the next iteration."
      end
    end

    puts "Article data inserted successfully!"
  end

  desc "insert_articles で作成したデータを削除する"
  task delete_articles: :environment do
    # 記事データの削除
    Article.where(belongable_type: 'GameArticle')
          .where(created_at: Time.zone.parse('2011-11-11 11:11:11')).destroy_all

    # GameArticle データの削除
    GameArticle.where(created_at: Time.zone.parse('2011-11-11 11:11:11')).destroy_all

    puts "Article data and related GameArticle data deleted successfully!"
  end

  desc "ランダムな大会データを投入する"
  task insert_tournaments: :environment do
    limit = 50

    limit.times do |index|
      tournament_data = {
        name: "大会#{index + 1}",  # 大会名
        created_at: Time.zone.parse('2011-11-11 11:11:11'),
      }

      # ランダムな記事検索ラベルと記事コンテンツを生成
      article_title = Faker::Lorem.sentence
      article_content = Faker::Lorem.paragraph

      # トーナメントと記事を作成
      tournament = Tournament.create!(tournament_data)
      tournament.create_article(title: article_title, content: article_content)
    end

    puts "tournament data inserted successfully!"
  end

  desc "insert_teamsで作成したTournamentデータを削除する"
  task delete_tournaments: :environment do
    Tournament.where(created_at: Time.zone.parse('2011-11-11 11:11:11')).destroy_all

    puts "Tournament data deleted successfully!"
  end

  desc "ランダムな大会/大会名データを投入する"
  task insert_tournament_records: :environment do
    limit = 50

    limit.times do |index|
      tournament = Tournament.order('RAND()').first
      tournament_record_data = {
        tournament_id: tournament.id,                # 既存の大会ID
        name: "第#{index + 1}回",                     # 大会名
        started_at: Faker::Date.backward(days: 365), # 開始日
        ended_at: Faker::Date.forward(days: 365),    # 終了日
        created_at: Time.zone.parse('2011-11-11 11:11:11'),
      }

      TournamentRecord.create!(tournament_record_data)
    end

    puts "TournamentRecord data inserted successfully!"
  end

  desc "insert_tournament_recordsで作成したTournamentRecordデータを削除する"
  task delete_tournament_records: :environment do
    TournamentRecord.where(created_at: Time.zone.parse('2011-11-11 11:11:11')).destroy_all

    puts "TournamentRecord data deleted successfully!"
  end

  desc "ランダムな選手データを投入する"
  task insert_players: :environment do
    limit = 50

    limit.times do |index|
      team = Team.order('RAND()').first
      player_data = {
        team_id: team.id,                   # 既存のチームID
        name: Faker::Name.name,             # 選手名
        kana: "フリガナ フリガナ",             # フリガナ
        alma_mater: "テスト#{index + 1}学校", # 出身校
        handedness: 1,                       # 投
        handedness_bat: 2,                   # 打
        position: Player.positions.keys.sample,  # ポジション
        created_at: Time.zone.parse('2011-11-11 11:11:11'),
      }

      Player.create!(player_data)
    end

    puts "Player data inserted successfully!"
  end

  desc "insert_playersで作成したplayerデータを削除する"
  task delete_players: :environment do
    Player.where(created_at: Time.zone.parse('2011-11-11 11:11:11')).destroy_all

    puts "Player data deleted successfully!"
  end

  desc "ランダムな試合データを投入する"
  task insert_games: :environment do
    limit = 50

    limit.times do |index|
      home_team = Team.order('RAND()').first
      away_team = Team.order('RAND()').where.not(id: home_team.id).first
      ground = Ground.order('RAND()').first
      tournament_record = TournamentRecord.order('RAND()').first

      game_data = {
        home_team_id: home_team.id,                                                  # 主催側
        away_team_id: away_team.id,                                                  # 対戦相手
        ground_id: ground.id,                                                        # 球場
        tournament_record_id: tournament_record.id,                                  # 大会/大会名
        start_time: Faker::Time.between(from: Date.today, to: 1.year.from_now), # ゲーム開始時刻
        tag_type: 0,                                                                 # 試合タグ
        created_at: Time.zone.parse('2011-11-11 11:11:11'),
      }

      Game.create!(game_data)
    end

    puts "Game data inserted successfully!"
  end

  desc "insert_gamesで作成したgameデータを削除する"
  task delete_games: :environment do
    Player.where(created_at: Time.zone.parse('2011-11-11 11:11:11')).destroy_all

    puts "Games data deleted successfully!"
  end
end

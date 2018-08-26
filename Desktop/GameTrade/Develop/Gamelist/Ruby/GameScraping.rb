require 'mysql2'
require 'open-uri'
require 'nokogiri'


client = Mysql2::Client.new(:host => "localhost", :username => "railsuser",
	:password => "railspass", :database => "GameList_development")

	#query = %q{insert into Game_Title("test")}

	#Gamewith　新作ゲームアプリ　配信カレンダー
	url = 'https://gamewith.jp/gamedb/article/show/18046?from=ios'

	charset = nil
	html = open(url) do |f|
		charset = f.charset
		f.read
	end

doc = Nokogiri::HTML.parse(html, nil, charset)

doc.css('.gdb-w-box-item').slice(0..3).each do |anchor|
		game_title = anchor.css('._title').inner_text
		article_url = anchor.css('._title').css('a').attribute('href').text

		img_url = anchor.css('img')
		icon_url = img_url.attribute('data-original').text

	##ゲーム記事のURLに上書き
	url = article_url
	charset = nil
	html = open(url) do |f|
		charset = f.charset
		f.read
	end

	doc = Nokogiri::HTML.parse(html, nil, charset)
 	#doc.css(".gdb-game-data_table").each do |anchor|
 		#doc.css(".gdb-game-data_table")
 	#end

 	#genre = doc.css('.article-table-wrap')
 	#doc.css('.article-table-wrap').each do |f|
 	table = doc.search("table th")

	release_OS = 0
	game_genre = "不明"
	release_date = "不明"

 	table.each do |f|
 		 if f.inner_text == "ジャンル"
 			 game_genre = f.next.text

 		elsif f.inner_text == "リリース"
 			release_date = f.next.inner_text

		elsif f.inner_text == "配信日"
			release_date = f.next.text

		elsif f.inner_text == "対応OS"
			tmp = f.next.inner_text
			os = f.next.inner_text.split(",")
				os.each do |r|
				if r == "iPhone"
					release_OS = 1
				elsif r == "Android"
					release_OS = 1
				end
			end
 		end
		#query = %q{insert into Game_Title Article_URL Media Icon_URL Genre Release_Date (game_title, article_url, icon_url, release_OS, release_date)}
 	end
	q = "insert into game_infos (Game_Title, Article_URL, Media, Icon_URL, Genre, Release_Date, Flag) values ('#{game_title}', '#{article_url}', '#{release_OS}', '#{icon_url}', '#{game_genre}', '#{release_date}', 0)"
	p q
	query = (q)
	client.query(query)

 	#doc.search("table tr:nth-child(i) td")
 	#doc.search("table th").inner_text
end

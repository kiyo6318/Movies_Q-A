genres =
["アクション","アドベンチャー","コメディ","クライム","ドキュメンタリー","ドラマ","家族","ファンタジー","歴史","ホラー","音楽","ミステリー",
  "ロマンス","SF","TVMovie","スリラー","戦争","西部"]

genres.each do |genre|
  Label.create(genre:"#{genre}")
  puts "test"
end
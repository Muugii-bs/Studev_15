# coding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.delete_all
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

User.delete_all
User.create!(id:1, point: 150, seat: 'dena1', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)
User.create!(id:2, point: 150, seat: 'dena2', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)
User.create!(id:3, point: 150, seat: 'dena3', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)
User.create!(id:4, point: 150, seat: 'dena4', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)
User.create!(id:5, point: 150, seat: 'dena5', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)
User.create!(id:6, point: 150, seat: 'dena6', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)
User.create!(id:7, point: 50, seat: 'dena7', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)
User.create!(id:8, point: 50, seat: 'dena8', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)
User.create!(id:9, point: 50, seat: 'dena9', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)
User.create!(id:10, point: 50, seat: 'dena10', password: 'aaaa', password_confirmation:'aaaa', game_id: 1)

Game.delete_all
Game.create!(id:1, date: Date.today.to_datetime, team1:'横浜DeNAベイスターズ', team2:'東京ヤクルトスワローズ')
Game.create!(id:2, date: Date.today.to_datetime, team1:'横浜DeNAベイスターズ', team2:'阪神タイガース')

Quiz.delete_all
Quiz.create!(
  id:1,
  title: '勝利チームは！？',
  content: '今日の試合はベイスターズが……',
  op1: '1点差で勝つ！',
  op2: '2～3点差で勝つ！！',
  op3: '4点差以上で勝つ！！！！',
  op4: '負ける……',
  odd_id: 1,
  hint:'対ヤクルト戦の勝率.557<br>ハマスタでの勝率.612'
)
Quiz.create!(id:2, title: '1回オモテ 守備',content: 'ピッチャー，この回は……', op1: 'ランナーを出すも無得点！', op2: '三者凡退！！', op3: '三者三振！！！', op4: '痛恨の失点……', odd_id: 2, hint:'小杉投手対ヤクルト戦1.57')
Quiz.create!(id:3, title: '3回ウラ 攻撃',content: 'ベイスターズの攻撃は……', op1: '1点取った！！', op2: '2点取った！', op3: '3得点以上！！！', op4: '無得点……', odd_id: 3, hint:'ベイスターズ内村賢介は今日誕生日！')
Quiz.create!(id:4, title: 'ラッキーセブンの攻撃',content: 'この回打者は……', op1: 'ヒット1本', op2: 'ヒット2本以上！', op3: 'ホームランを打つ！！！', op4: '三者凡退……', odd_id: 4, hint: 'ラッキーセブンの得点率 .468')
Quiz.create!(id:5, title: '9回オモテ 守備',content: 'ピッチャー，この回は……', op1: '三者凡退で勝利！', op2: 'ランナーを出すも無失点！', op3: '同点に追いつかれる……', op4: 'まさかの逆転……', odd_id: 5, hint:'山口俊投手は今季8セーブ。<br>好きなスイーツはモンブラン')

Odd.delete_all
Odd.create!(id:1, op1: 4.0, op2: 4.0, op3: 4.0, op4: 4.0) 
Odd.create!(id:2, op1: 4.0, op2: 4.0, op3: 4.0, op4: 4.0) 
Odd.create!(id:3, op1: 4.0, op2: 4.0, op3: 4.0, op4: 4.0) 
Odd.create!(id:4, op1: 4.0, op2: 4.0, op3: 4.0, op4: 4.0) 
Odd.create!(id:5, op1: 4.0, op2: 4.0, op3: 4.0, op4: 4.0) 

Bet.delete_all
5.times do |i|
  Bet.create!(id:1+(i*4), user_id:7, quiz_id:i, answer:4, amount:20)
  Bet.create!(id:2+(i*4), user_id:8, quiz_id:i, answer:3, amount:20)
  Bet.create!(id:3+(i*4), user_id:9, quiz_id:i, answer:2, amount:20)
  Bet.create!(id:4+(i*4), user_id:10, quiz_id:i, answer:1, amount:20)
end

GameQuiz.delete_all
GameQuiz.create!(id:1, quiz_id: 1, game_id: 1)
GameQuiz.create!(id:2, quiz_id: 2, game_id: 2)
GameQuiz.create!(id:3, quiz_id: 3, game_id: 3)
GameQuiz.create!(id:4, quiz_id: 4, game_id: 4)


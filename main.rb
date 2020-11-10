require 'selenium-webdriver'
require 'pry'

url = gets.chomp.to_s
d = Selenium::WebDriver.for :chrome

# d.navigate.to 'https://quizknock.com/jyoshiki-knock-1'
d.navigate.to "#{url}"
sleep 3

question_group_text = d.find_element(:class, 'question_group')
q_split_word = question_group_text.text.split(/\n/)

answers_array = question_group_text.attribute('textContent').split # Answers
answers = answers_array.map.with_index{|v,i| answers_array[i+1] if v == 'A.'}.compact

questions = []
answer_choices = []

q_index = -1 #最初のindexを0にしたいため
q_cnt = false
q_split_word.each_with_index do |word, i|
  if word.include?('Q')
    q_index += 1
    questions << []
    answer_choices << []
    q_cnt = true

    next
  end
  if q_cnt
    questions[q_index] << word
  else
    answer_choices[q_index] << word
  end

  q_cnt = false
end

# binding.pry
puts "問題 => #{questions}\n選択肢 => #{answer_choices}\n答え => #{answers}"
d.quit
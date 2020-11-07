require 'selenium-webdriver'
require 'pry'

d = Selenium::WebDriver.for :chrome

d.navigate.to 'https://quizknock.com/jyoshiki-knock-1'
sleep 3

question_group_text = d.find_element(:class, 'question_group').text
q_split_word = question_group_text.split(/\n/)

questions = []
answer_choices = []
answers = []
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
d.quit
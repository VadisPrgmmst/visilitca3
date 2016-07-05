# coding: utf-8

require 'unicode'

class Game

  attr_accessor :letters, :errors_count, :bad_letters, :good_letters, :status

  def initialize(word)
    @letters = get_letters(word)
    @errors_count = 0
    @bad_letters = []
    @good_letters = []
    @status = 0  # 0 продолжаем, -1 проиграл, 1 выйграл
  end

  def ask_next_letter
    puts 'Введите следующую букву...'
    letter = ''
    while letter == ''
      letter = Unicode::downcase(STDIN.gets.chomp)
    end
    make_next_step(letter)
  end

private
  def get_letters(word)
    if word == nil || word == ''
      abort 'Вы не ввели слово для игры'
    end
    Unicode::downcase(word).split('')
  end

  def make_next_step(letter)
    return unless @status == 0
    return if (@good_letters + @bad_letters).include? letter

    if guessed? letter
      add_to_good(letter)
      @status = 1 if (@letters - @good_letters).empty?
    else
      @bad_letters << letter
      @errors_count += 1
      @status = -1 if @errors_count >= 7
    end
  end

  def guessed?(letter)
    @letters.include?(letter) ||
    (letter == 'е' && @letters.include?('ё')) ||
    (letter == 'ё' && @letters.include?('е')) ||
    (letter == 'и' && @letters.include?('й')) ||
    (letter == 'й' && @letters.include?('и'))
  end

  def add_to_good(letter)
    @good_letters << letter
    @good_letters << 'е' if letter == 'ё'
    @good_letters << 'ё' if letter == 'е'
    @good_letters << 'и' if letter == 'й'
    @good_letters << 'й' if letter == 'и'
  end
end

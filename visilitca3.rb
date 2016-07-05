#coding: utf-8

require_relative 'lib/game'
require_relative 'lib/result_printer'

images = Dir["#{File.dirname(__FILE__)}/image/*.txt"].sort
words = File.readlines "#{File.dirname(__FILE__)}/data/words.txt"

result_printer = ResultPrinter.new(images)
game = Game.new(words.sample.chomp)

while (game.status).zero? do
  result_printer.print_status(game)
  game.ask_next_letter
end

result_printer.print_status(game)

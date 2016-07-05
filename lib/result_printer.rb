# coding: utf-8

class ResultPrinter
  def initialize(images)
    @status_image = []
    images.each do |i|
      if File.exist?(i)
        File.open(i){ |f| @status_image << f.read}
      else
        @status_image << "\n[ Изображение не найдено ]\n"
      end
    end
  end

  def print_status(game)
    cls
    puts "Слово: #{get_word_for_print(game.letters, game.good_letters)}"
    print_visilitsa(game.errors_count)
    case game.status
    when 1
      puts 'Поздравляем вы выйграли ;)'
    when -1
      puts 'К сожалению вы проиграли ((('
      puts "Было загаданно слово: #{game.letters.join('')}"
    else
      puts 'У вас осталось ' +
        "#{7 - game.errors_count} #{sklonenie(game.errors_count, 'попытка', 'попытки', 'попыток')}"
      puts "Ошибки: #{game.bad_letters.join(', ')}"
    end
  end

private
  def get_word_for_print(letters, good_letters)
    word = ''
    for item in letters do
      if good_letters.include? item
        word << item + ' '
      else
        word << '__ '
      end
    end
    return word
  end

  def sklonenie(errors, popitka, popitki, popitok)
    ostatok = (7 - errors) % 10
      case ostatok
        when 1 then return popitka
        when 2..4 then return popitki
        when 5..6 then return popitok
      end
  end

  def cls
    system 'clear'
  end

  def print_visilitsa(errors)
    puts @status_image[errors]
  end
end
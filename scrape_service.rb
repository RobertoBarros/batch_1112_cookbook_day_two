require 'open-uri'
require 'nokogiri'

class ScrapeService
  def initialize(keyword)
    @keyword = keyword
    @view = View.new
  end

  def call
    # 1. Montar a URL e carregar o HTML
    url = "https://www.bbcgoodfood.com/search?q=#{@keyword}"
    doc = Nokogiri::HTML.parse(URI.open(url).read)

    # 3. Mostrar as top 5 receitas
    urls = []
    doc.search('a.standard-card-new__article-title').first(5).each_with_index do |link, index|
      puts "#{index + 1} - #{link.text.strip}"
      urls << "https://www.bbcgoodfood.com#{link.attribute('href').value}"
    end

    # Perguntar o index da receita para importar
    index = @view.ask_index
    url = urls[index]
    doc = Nokogiri::HTML.parse(URI.open(url).read)

    # Parse do html
    name = doc.search('h1').text
    description = doc.search('.editor-content')[0].text
    prep_time = doc.search('.cook-and-prep-time time')[0].text
    rating = doc.search('.rating__values .sr-only').first.text.match(/A star rating of (\d\.\d)/)[1].to_f.round(0)

    # Cria e retorna uma nova instância de Recipe
    Recipe.new(name, description, rating, prep_time)
  end
end

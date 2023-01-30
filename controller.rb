class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    # 1. Pegar as receitas do cookbook
    recipes = @cookbook.all

    # 2. Mandar a view exibir as receitas
    @view.display_list(recipes)
  end

  def add
    # 1. Perguntar qual o nome da receita
    name = @view.ask_name

    # 2. Perguntar qual a descriçao da receita
    description = @view.ask_description

    # 3. Perguntar qual a nota da receita
    rating = @view.ask_rating

    # 3. Perguntar o tempo de preparo
    prep_time = @view.ask_prep_time

    # 4. Instanciar uma nova receita
    new_recipe = Recipe.new(name, description, rating, prep_time)

    # 5. Criar a receita no cookbook
    @cookbook.create(new_recipe)

  end

  def remove
    # 1. Listar as receitas
    list

    # 2. Perguntar o index da receita que quer remover
    index = @view.ask_index

    # 2.5 Mostrar o nome da receita removida
    recipe_name = @cookbook.all[index].name
    @view.show_removed_recipe(recipe_name)


    # 3. Mandar o cookbook remover pelo index
    @cookbook.destroy(index)
  end

  def mark
    # 1. Listar as receitas
    list

    # 2. Perguntar o index da receita que quer marcar como feito
    index = @view.ask_index

    # 3. mandar o cookbook marcar como feito
    @cookbook.mark_as_done(index)
  end

  def import
    # 1. Perguntar o ingrediente
    ingredient = @view.ask_ingredient

    # Usar o serviço de scrape
    scrape = ScrapeService.new(ingredient)
    recipe = scrape.call

    # Adicionar a recipe no cookbook
    @cookbook.create(recipe)

  end
end

class View
  def display_list(recipes)
    recipes.each_with_index do |recipe, index|
      done = recipe.done? ? "[X]" : "[ ]"

      puts "#{index + 1} #{done} - Name: #{recipe.name}: Description: #{recipe.description} - (#{recipe.rating} / 5) - Preparation Time: #{recipe.prep_time}"
    end
  end

  def ask_name
    puts "Enter recipe name:"
    gets.chomp
  end

  def ask_description
    puts "Enter recipe description:"
    gets.chomp
  end

  def ask_rating
    puts "Enter recipe rating (1-5)"
    gets.chomp.to_i
  end

  def ask_prep_time
    puts "Enter recipe preparation time:"
    gets.chomp
  end

  def ask_index
    puts "Enter index:"
    gets.chomp.to_i - 1
  end

  def ask_ingredient
    puts "Enter ingredient to import:"
    gets.chomp
  end

  def show_removed_recipe(recipe_name)
    puts "#{recipe_name} removed!"
  end
end

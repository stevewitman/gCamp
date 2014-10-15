class PagesController < ApplicationController

  def index
    @quotes = [
                ["\"Failure is not an option, Everyone has to Succeed\"", "Arnold Scwarzenegger"],
                ["\"Your time is limited, so don\'t waste it living someone else's life.\"", "Steve Jobs"],
                ["\"Better Ingredients, Better Pizza\"", "Papa John"]
              ]
  end

end

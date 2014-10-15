class PagesController < ApplicationController

  def index


    quote1 = Quote.new
    quote1.text = "Failure is not an option, Everyone has to Succeed"
    quote1.author = "Arnold Scwarzenegger"

    quote2 = Quote.new
    quote2.text = "Your time is limited, so don\'t waste it living someone else's life."
    quote2.author = "Steve Jobs"

    quote3 = Quote.new
    quote3.text = "Better Ingredients, Better Pizza"
    quote3.author = "Papa John"

    @quotes = [quote1, quote2, quote3]

  end

end

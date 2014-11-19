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

  def faq
    faq1 = Faq.new
    faq1.question = "What is gCamp?"
    faq1.answer = "gCamp is an qwesome tool that is going to change your life.
    gCamp os your one stop shop to organize all your tasks and documents.  You'll
    also be able to track comments that you and others make.  gCamp may eventually
    replace all need for paper and pens in the entire world.  Well, maybe not, but
    it is going to be pretty cool."
    faq2 = Faq.new
    faq2.question = "How do I join gCamp?"
    faq2.answer = "Begin your application <here (make this a link)>"
    faq3 = Faq.new
    faq3.question = "When will gCamp be finished?"
    faq3.answer = "Answer here ..."
    @faq = [faq1, faq2, faq3]
  end
end

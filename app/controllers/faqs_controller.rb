class FaqsController < ApplicationController

  def faq
    @quotes = Faq.all
  end

end

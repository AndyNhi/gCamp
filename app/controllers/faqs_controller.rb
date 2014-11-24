class FaqsController < ApplicationController

  def faq
    @faqs = Faq.all
  end

end

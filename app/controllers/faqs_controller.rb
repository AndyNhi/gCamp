class FaqsController < PublicController

  def faq
    @faqs = Faq.all
  end

end

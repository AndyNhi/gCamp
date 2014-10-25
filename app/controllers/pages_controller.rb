class PagesController < ApplicationController

  def index

    @columns = {
      Task: ['Group Project and list just the way you like them.'],
      Documents: ['Upload', 'Comment', 'Revise'],
      Comments: ['Comments on task and documents','Get email notifications']
      }

    @qas = Page.all
    
  end
end

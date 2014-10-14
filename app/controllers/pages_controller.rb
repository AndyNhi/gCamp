class PagesController < ApplicationController

def index
  @columns = {
    Task: ['Group Project and list just the way you like them.'],
    Documents: ['Upload', 'Comment', 'Revise'],
    Comments: ['Comments on task and documents','Get email notifications']
    }

  @quote_author_array = [
    ['Tupac',['Death is not the greatest loss in life. The greatest loss is what dies inside while still alive. Never surrender.']],
    ['Albert Einstein',['The difference between stupidity and genius is that genius has its limits.']],
    ['George Carlin',['Those who dance are considered insane by those who cannot hear the music.']]
    ]
    
  render :index
end



end

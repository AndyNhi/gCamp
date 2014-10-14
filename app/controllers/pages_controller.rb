class PagesController < ApplicationController

def index
  @columns = {
    Task: ['Group Project and list just the way you like them.'],
    Documents: ['Upload', 'Comment', 'Revise'],
    Comments: ['Comments on task and documents','Get email notifications']
    }

  quote_author_array = [
    ['Tupac',['Death is not the greatest loss in life. The greatest loss is what dies inside while still alive. Never surrender.']],
    ['Albert Einstein',['The difference between stupidity and genius is that genius has its limits.']],
    ['George Carlin',['Those who dance are considered insane by those who cannot hear the music.']],
    ['Muhammed Ali',['I hated every minute of training, but I said, Dont quit. Suffer now and live the rest of your life as a champion.']],
    ['Will Smith',['Money and success dont change people; they merely amplify what is already there.']],
    ['Will Smith',['Ive always considered myself to be just average talent and what I have is a ridiculous insane obsessiveness for practice and preparation.']],
    ['Maya Angelou',['Nothing will work unless you do.']],
    ['Thomas Alva Edison',['Opportunity is missed by most because it is dressed in overalls and looks like work.']],
    ['Confucius',['The superior man is modest in his speech, but exceeds in his actions.']],
    ['Martha Graham',['Dancers are the messengers of the gods.']],
    ['George Bernard Shaw',['Dancing: the vertical expression of a horizontal desire legalized by music. ']],
    ]

  @random_quote_generation = quote_author_array.sample(3)

  render :index
end



end

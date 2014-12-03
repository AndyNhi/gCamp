require 'rails_helper'

describe 'Comment' do

  it 'is valid with a user' do
    expect(create_comment).to be_valid
  end

  it 'should have an associated user' do
    user = create_user
    comment = create_comment(user_id: user.id)
    expect(comment.user_id).to eq(user.id)
  end

end

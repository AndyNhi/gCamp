class PublicController < ApplicationController

  skip_before_action :validates_user_is_present

end

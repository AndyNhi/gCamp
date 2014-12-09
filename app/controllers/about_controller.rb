class AboutController < PublicController

  def about
    @projects = Project.all.count
    @tasks = Task.all.count
    @members = Membership.all.count
    @users = User.all.count
    @comments = Comment.all.count
  end



end

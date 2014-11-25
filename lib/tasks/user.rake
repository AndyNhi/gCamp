namespace :membership do

  desc "This will find invalid memberships"
  task find: :environment do
      p Membership.where.not(user_id: User.pluck(:id)).count
  end

  desc "This will delete invalid memberships"
  task delete: :environment do
    Membership.where.not(user_id: User.pluck(:id)).destroy_all
  end

end

namespace :comment do

  desc "This will find comments with no user"
  task find: :environment do
     p Comment.where.not(user_id: User.pluck(:id)).count
  end

  desc "This will delete comments with no user"
  task delete: :environment do
    Comment.where.not(user_id: User.pluck(:id)).destroy_all
  end


end

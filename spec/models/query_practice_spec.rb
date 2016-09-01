require 'rails_helper'

RSpec.describe QueryPractice, type: :model do

  it "can identify donations between 0 and 100" do


  end

  it "can identify donations between 0 and 100" do

  end

  it "can identify donations between 0 and 100" do

  end


end

# Things that I got working:

#needs with prices less than 10
Need.where(price: (0..10))
#top 2 highest priced needs
Need.order(price: :desc).take(2)

#user roles that are admin - but this is dumb because i can do this without the joins?  i can't really figure out any thing interesting bc i really want to go the other where
UserRole.joins(:user).where(role_id: [2, 3, 4]) #why can't i go backwards...You can call joins on something that carries the other things id as a foriegn key
#i can hack the reverse liks this:
admin_user_ids = UserRole.joins(:user).where(role_id: [2, 3, 4]).pluck(:user_id)
User.where(id: admin_user_ids)

#need items that have a deadline, or within a range
NeedItem.where.not(deadline: nil)
NeedItem.where(deadline: 0.day.ago..2.days.from_now)
NeedItem.where(deadline: 1.day.ago..2.days.from_now)

##
Donation.group(:user_id).count
Need.group(:needs_category_id).count
num recipients with need items? 85
Recipients with a need item quantity of 1

Recipient.includes(:need_items).where(need_items: {quantity: 1})
Recipient.joins(:need_items).distinct.count
WHAT IS THIS
Recipient.includes(:need_items) -- when you count that its 100

recipients with need items:
Recipient.joins(:need_items).distinct


How come this works:
Need.joins(:needs_category).group(:needs_category).count
but this doesnt:
Need.joins(:needs_category).group(:needs_category)
finally got this to work, but dont understand - and not sure what it is
Need.joins(:needs_category).group("needs.needs_category_id, needs.id")


why doesnt this work
Recipient.select("name, charity_id").group("charity_id")
DonationItem.select("need_item_id, quantity").group("need_item_id").having("quantity >?", 1)

I dont understand what this is doing - we dont have an author?  Just all authors with posts?
Author.joins("INNER JOIN posts ON posts.author_id = author.id AND posts.published = 't'")

Why does
Charity.joins(:recipient) does notwork
Recipient.joins(:charity)  works?
becuase recipient carries the foriegn key?
Isn't the join pointless because all ch










class Category < ApplicationRecord
  has_many :articles
end

class Article < ApplicationRecord
  belongs_to :category
  has_many :comments
  has_many :tags
end

class Comment < ApplicationRecord
  belongs_to :article
  has_one :guest
end

class Guest < ApplicationRecord
  belongs_to :comment
end

class Tag < ApplicationRecord
  belongs_to :article
end


return a Category object for all categories with articles"
what if you want unique categories
return all articles that have a category and at least one comment
return all articles that have a comment made by a guest.
return all categories that have articles, where those articles have a comment made by a guest, and where those articles also have a tag.
clients with orders that were created yesterday

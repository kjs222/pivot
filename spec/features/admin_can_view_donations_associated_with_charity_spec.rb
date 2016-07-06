require 'rails_helper'

RSpec.feature "admin can see individual donation associated with charity" do
  scenario "business admin can see donation" do

    role = Role.find_by(name: 'Business Admin')
    donor = User.create(username: "donor", password: "password", email: "email@example.com")
    user = create(:user)
    status = create(:status)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    need1 = charity.needs.create(name: "Need1", description: "description for Need1", price: 10, needs_category: create(:needs_category))
    recipient = charity.recipients.create(name: "Recipient", description: "Recipient description", charity_id: charity.id)
    need_item = charity.needs.find(need1.id).need_items.create(quantity: 1, recipient_id: recipient.id)
    donation = Donation.create(user_id: donor.id)
    donation_item = charity.need_items.first.donation_items.create(quantity: 1, donation_id: donation.id, need_item_id: need_item.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_donations_path(charity.slug)

    expect(page).to have_content "All Donations for #{charity.name}"
    within ".donation-#{donation.id}" do
      click_on "View Details"
   end
   expect(current_path).to eq(admin_charity_donation_path(charity.slug, donation))

   expect(page).to have_content("Donation ID: #{donation.id}")
   expect(page).to have_content("Username of Donor: #{donor.username}")
   expect(page).to have_content("Date Placed:" )
 end

 scenario "business owner can see donation" do

   role = Role.find_by(name: 'Business Owner')
   donor = User.create(username: "donor", password: "password", email: "email@example.com")
   user = create(:user)
   charity = create(:charity)
   user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
   create(:status)
   need1 = charity.needs.create(name: "Need1", description: "description for Need1", price: 10, needs_category: create(:needs_category))
   recipient = charity.recipients.create(name: "Recipient", description: "Recipient description", charity_id: charity.id)
   need_item = charity.needs.find(need1.id).need_items.create(quantity: 1, recipient_id: recipient.id)
   donation = Donation.create(user_id: donor.id)
   donation_item = charity.need_items.first.donation_items.create(quantity: 1, donation_id: donation.id, need_item_id: need_item.id)
   allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

   visit admin_charity_donations_path(charity.slug)
   expect(page).to have_content "All Donations for #{charity.name}"
   within ".donation-#{donation.id}" do
     click_on "View Details"
  end
  expect(current_path).to eq(admin_charity_donation_path(charity.slug, donation))

  expect(page).to have_content("Donation ID: #{donation.id}")
  expect(page).to have_content("Username of Donor: #{donor.username}")
  expect(page).to have_content("Date Placed:" )
  end

  scenario "platform admin can see all donations, regardless of charity" do
    role = Role.find_by(name: 'Platform Admin')
    donor = User.create(username: "donor", password: "password", email: "email@example.com")
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create(:status)
    need1 = charity.needs.create(name: "Need1", description: "description for Need1", price: 10, needs_category: create(:needs_category))
    recipient = charity.recipients.create(name: "Recipient", description: "Recipient description", charity_id: charity.id)
    need_item = charity.needs.find(need1.id).need_items.create(quantity: 1, recipient_id: recipient.id)
    donation = Donation.create(user_id: donor.id)
    donation_item = charity.need_items.first.donation_items.create(quantity: 1, donation_id: donation.id, need_item_id: need_item.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_donations_path(charity.slug)
    expect(page).to have_content "All Donations for #{charity.name}"
    within ".donation-#{donation.id}" do
      click_on "View Details"
   end
   expect(current_path).to eq(admin_charity_donation_path(charity.slug, donation))

   expect(page).to have_content("Donation ID: #{donation.id}")
   expect(page).to have_content("Username of Donor: #{donor.username}")
   expect(page).to have_content("Date Placed:" )
  end

  scenario "platform admin can see all donations, regardless of charity" do
    role = Role.find_by(name: 'Registered User')
    donor = User.create(username: "donor", password: "password", email: "email@example.com")
    user = create(:user)
    charity = create(:charity)
    user_role = UserRole.create(role_id: role.id, user_id: user.id, charity_id: charity.id)
    create(:status)
    need1 = charity.needs.create(name: "Need1", description: "description for Need1", price: 10, needs_category: create(:needs_category))
    recipient = charity.recipients.create(name: "Recipient", description: "Recipient description", charity_id: charity.id)
    need_item = charity.needs.find(need1.id).need_items.create(quantity: 1, recipient_id: recipient.id)
    donation = Donation.create(user_id: donor.id)
    donation_item = charity.need_items.first.donation_items.create(quantity: 1, donation_id: donation.id, need_item_id: need_item.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return( user )

    visit admin_charity_donations_path(charity.slug)

    expect(page).to have_content("not authorized")
    expect(current_path).to eq(root_path)
  end
end

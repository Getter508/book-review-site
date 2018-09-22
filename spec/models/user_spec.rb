require 'rails_helper'

RSpec.describe User, type: :model do
  scenario "user has a first name, last name, and role" do
    user = FactoryBot.create(:user)

    expect(user.first_name).to eq("Sarah")
    expect(user.last_name).to eq("Getter")
    expect(user.admin).to be_truthy
  end
end

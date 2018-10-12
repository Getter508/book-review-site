require 'rails_helper'

RSpec.describe Author, type: :model do
  scenario "has a first name and last name, optionally a middle and suffix" do
    author = FactoryBot.create(:author)

    expect(author.first_name).to eq('Patrick')
    expect(author.last_name).to eq('Rothfuss')
    expect(author.middle_name).to be_nil
    expect(author.suffix).to be_nil
  end
end

describe '#full_name' do
  scenario 'it displays full name of the author' do
    author = FactoryBot.create(:author)

    expect(author.full_name).to eq('Patrick Rothfuss')
  end
end

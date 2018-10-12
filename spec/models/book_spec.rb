require 'rails_helper'

RSpec.describe Book, type: :model do
  scenario "book has a title, optionally a genre, year, synopsis, and image" do
    book = FactoryBot.create(:book)

    expect(book.title).to eq('The Name of the Wind')
    expect(book.genre).to eq('Fantasy')
    expect(book.year).to eq(2007)
    expect(book.synopsis).to eq("So begins the tale of Kvothe—from his childhood in a troupe of \
      traveling players, to years spent as a near-feral orphan in a \
      crime-riddled city, to his daringly brazen yet successful bid to enter a \
      difficult and dangerous school of magic. In these pages you will come to \
      know Kvothe as a notorious magician, an accomplished thief, a masterful \
      musician, and an infamous assassin. But The Name of the Wind is so much \
      more—for the story it tells reveals the truth behind Kvothe's legend.")
  end
end

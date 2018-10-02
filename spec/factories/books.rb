FactoryBot.define do
  factory :book do
    title {"The Name of the Wind"}
    year {2007}
    genre {"Fantasy"}
    synopsis {"So begins the tale of Kvothe—from his childhood in a troupe of \
      traveling players, to years spent as a near-feral orphan in a \
      crime-riddled city, to his daringly brazen yet successful bid to enter a \
      difficult and dangerous school of magic. In these pages you will come to \
      know Kvothe as a notorious magician, an accomplished thief, a masterful \
      musician, and an infamous assassin. But The Name of the Wind is so much \
      more—for the story it tells reveals the truth behind Kvothe's legend."}
    # image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/NameofWindCover.jpg'), 'image/jpeg') }

    user
    author
  end
end

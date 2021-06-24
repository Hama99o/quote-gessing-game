FactoryBot.define do
  factory :game do
    quote { "The value and utility of any experiment are determined by the fitness of the material to the purpose for which it is used, and thus in the case before us it cannot be immaterial what plants are subjected to experiment and in what manner such experiment is conducted." }
    author { "Gregor Mendel" }
    fake_authors { ["Claudia Christian", "Nils-Axel Morner"] }
  end
end

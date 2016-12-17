# encoding: utf-8

FactoryGirl.define do
  factory :performer, class: 'Kleiber::Performer' do
    skip_create

    symphony { build(:symphony) }
    projects { [] }
    options  { {} }

    initialize_with { new(symphony, projects, options) }
  end
end

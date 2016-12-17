# encoding: utf-8

FactoryGirl.define do
  factory :project, class: 'Kleiber::Project' do
    skip_create

    sequence(:name) { |n| "project#{n}" }
    prefix          { name.sub('ect', '').upcase }
    path            { "/home/user/projects/#{name}" }
    guest_port      { rand(1000...9999) }
    host_port       { guest_port }
    host            { "192.168.#{rand(2..255)}.#{rand(2..255)}" }

    trait :with_env do
      env { FactoryGirl.build(:env) }
    end

    trait :with_tasks do
      tasks { FactoryGirl.build(:tasks) }
    end

    initialize_with { new(attributes) }
  end
end

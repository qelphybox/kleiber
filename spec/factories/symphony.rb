# encoding: utf-8

FactoryGirl.define do
  factory :symphony, class: 'Kleiber::Symphony' do
    skip_create
    sequence(:name) { |n| "symphony#{n}" }

    transient do
      projects_count 2
    end

    projects { FactoryGirl.create_list(:project, projects_count) }

    tasks { build(:tasks) }

    trait :project_env do
      projects { FactoryGirl.create_list(:project, projects_count, :with_env) }
    end

    initialize_with { new(name, projects, tasks: tasks) }
  end
end

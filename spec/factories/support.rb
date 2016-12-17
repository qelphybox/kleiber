# encoding: utf-8

FactoryGirl.define do
  factory :hash, class: 'Hash' do
    skip_create
    initialize_with { attributes }
  end

  factory :tasks, parent: :hash do
    setup   'bundle install'
    run     'bundle exec rails s'
    console 'bundle exec rails c'
  end

  factory :env, parent: :hash do
    OTHER_HOST   '192.168.33.123'
    OTHER_PORT   '1111'
  end
end

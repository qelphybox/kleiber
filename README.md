# Kleiber
Manage your development enviroments faster!

![Carlos Kleiber](http://glasove.com/images/crops/32544_IAiSTZMEfO1QnQHfvwvghswY229lKS-560x315-trim%280,0,950,533%29.jpg)

[Carlos Kleiber](https://en.wikipedia.org/wiki/Carlos_Kleiber) (3 July 1930 – 13 July 2004) was a German-born Austrian conductor who is widely regarded as being among the greatest conductors of the 20th century.

## Description

Kleiber provides an interface for control multiple vagrant machines. In case when you have distributed system of applications, each application have its vagrant machine and you need to manage system locally in development order Kleiber may be useful.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kleiber'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kleiber

## Usage
### Projects config
At first you need to compose projects config. It's `.yml` file with structure like that:

    ---
    projects:
      project1:
      prefix: PROJ1 # prefix for environment variables with project settings
        dir: /path/to/project/dir
        guest_port: 8000
        host_port: 8000
        host: 125.12.123.42
        tasks:
          setup: 'npm install'
          run: 'node start'

      project2:
        prefix: PROJ2

      project3:
        prefix: PROJ3

    tasks:
      setup: 'bundle install --jobs 4'
      run: 'bundle exec rails s -p %{guest_port}'
      console: 'bundle exec rails c'
You can create tasks as many as you want and name it as you need.

### Command Line Interface
Sample command struture is `kleiber [vagrant command] <project names> <-c config_path> <-t tasks divided by colon (:)>`.

    $ kleiber up
    $ kleiber halt project1 project2
    $ kleiber ssh -t setup:run
    $ kleiber --help # use it first

## Development
Recommended to install [Vagrant](https://www.vagrantup.com/).
`vagrant up && vagrant ssh` - switch on and get access to development vagrant machine.
`bin/setup` - install dependecies and setup app.
`bundle exec rspec` - to run tests.
`bundle exec rake install` - install gem on your local machine.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qelphybox/kleiber. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

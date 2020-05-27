### Project is dead, if you want to maintain it, let me know.

# Kleiber
Manage your development enviroments faster!

![Carlos Kleiber](http://glasove.com/images/crops/32544_IAiSTZMEfO1QnQHfvwvghswY229lKS-560x315-trim%280,0,950,533%29.jpg)

[Carlos Kleiber](https://en.wikipedia.org/wiki/Carlos_Kleiber) (3 July 1930 – 13 July 2004) was a German-born Austrian conductor who is widely regarded as being among the greatest conductors of the 20th century.

## Description

Kleiber provides an interface for control multiple vagrant machines. In case when you have distributed system of applications, each application have its vagrant machine and you need to manage system locally in development order Kleiber may be useful.

Kleiber combines *projects* into groups called *symphonies* which can be used over centralized control. Using projects combined in symphonies provides general environment for all used projects. Also vagrant provides *tasks* interface for control applications in vagrant.

## Requirements
 On your HOST machine:
 
- ruby >= 2.0
- vagrant

## Installation
Install it manually
```
gem install kleiber
```

## Usage
Kleiber provides simple CLI.
```bash
kleiber <vagrant command> <symphony name> [projects] [-t tasks:chain:colon:separated ]
```
Examples:
```bash
kleiber up symphony1 # calls vagrant up for symphonies
kleiber up symphony1 -t setup:run # calls vagrant up && vagrant ssh -c 'setupcommand... && runcommand...'
kleiber halt symphony1 project1 # calls vagrant ssh for project1 in symphony1
```

## Configuration
Before start to use kleiber you need to make config like this:
```yaml
---
# List of projects which kleiber can use in its symphonies
:projects:
  - :name: project1
    :prefix: PROJ1
    :path: /path/to/project/dir
    :guest_port: 8000
    :host_port: 8000
    :host: 125.12.123.42
    :tasks:
      setup: 'npm i'
      run: 'node start'
    :env:
      ANOTHERONE_HOST: 192.168.33.33

  - :name: project2
    :prefix: PROJ2
    :path: /path/to/project/dir
    :guest_port: 8000
    :host_port: 8000
    :host: 125.12.123.42

# Dictionary of tasks with the lowest priority for all projects and symphonies
# Actually, we can call it like 'list of default task values'
:tasks:
  setup: 'bundle install --jobs 4'
  run: 'bundle exec rails s -p %{port}'
  console: 'bundle exec rails c'

# Dictionary of symphonies which kleiber can perform
:symphonies:
  symphony1:
    :projects: ['project1', 'project2']
    :tasks:
      setup: 'bundle'
      run: 'rails c'
    :env:
      OTHER_HOST: 127.0.0.1

# Working terminal settings
:terminal:
  :exec: 'gnome-terminal'
  :new_tab: '--tab'
  :exec_command: '-e'
```
### Project parameters
| Key          | Type      | Description                                  |
|--------------|-----------|----------------------------------------------|
| name *       | string    | Project identificator                        |
| prefix *     | string    | Prefix for HOST and PORT env variables       |
| path *       | string    | Absolute path to project directory           |
| guest_port * | number    | Vagrant guest port                           |
| host_port *  | number    | Vagrant host port                            |
| host *       | string    | Vagrant host ip address                      |
| tasks        | key/value | List of task definitions for project         |
| env          | key/value | List of env variables definition for project |

\* - required parameters

`tasks` defined values have the highest priority. That means if one defined, it will be used when task required to execute for project in symphony.

### Symphony parameters
| Key        | Type      | Description                                   |
|------------|-----------|-----------------------------------------------|
| projects * | list      | List of projects uses in one symphony         |
| tasks      | key/value | List of task definitions for symphony         |
| env        | key/value | List of env variables definition for symphony |

\* - required parameters

`tasks` defined values have lower priority than project task values. That means, it will be used if project value isn't defined.



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

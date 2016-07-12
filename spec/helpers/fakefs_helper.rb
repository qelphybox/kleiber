# encdoing: utf-8

module FakefsSpecHelper
  def config_stub
    Kleiber::Project::Config.new(parsed_config)
  end

  private

  def parsed_config
    init_directories[0]
  end

  def init_directories
    load_projects.each do |project|
      FileUtils.mkdir_p(project['path'])
    end
  end

  def load_projects
    YAML.load(projects_yml)
  end

  def projects_yml
    <<-YAML
---
- name: proj1
  prefix: PROJ1
  path: /projects/proj1

- name: proj2
  prefix: PROJ2
  path: /projects/proj2

- name: proj3
  prefix: PROJ3
  path: /projects/proj3
YAML
  end
end

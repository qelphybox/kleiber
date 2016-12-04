# encoding: utf-8

module KleiberSpecHelper
  def project_stub
    Kleiber::Project.new(config_stub)
  end

  def config_stub
    Kleiber::Config.new(config_attrs_stub, true)
  end

  def config_attrs_stub
    {
      'path' => '/asdf/asdf',
      'name' => 'project1',
      'prefix' => 'PROJ1'
    }
  end
end

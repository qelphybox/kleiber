$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'kleiber'
require 'rubygems'
require 'fakefs/spec_helpers'
Dir["#{__dir__}/helpers/*.rb"].each { |helper| require helper }

FIXTURES_PATH = "#{__dir__}/fixtures"

RSpec.configure do |config|
  config.include FakeFS::SpecHelpers
  config.include FakefsSpecHelper
  ports_stub = ['unset RUBYLIB', '/usr/bin/vagrant port'].join("\n")
  host_stub = ['unset RUBYLIB',
               '/usr/bin/vagrant up --no-provision &> /dev/null',
               "/usr/bin/vagrant ssh -c 'ifconfig'"].join("\n")

  config.before(:each) do
    allow_any_instance_of(Kleiber::Project::Config).to receive(:`).with(ports_stub) do
      <<-SHELL
          22 (guest) => 2200 (host)
        8080 (guest) => 8080 (host)
      SHELL
    end
    allow_any_instance_of(Kleiber::Project::Config).to receive(:`).with(host_stub) do
      <<-SHELL
eth0      Link encap:Ethernet  HWaddr 08:00:27:8b:9e:d0
          inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fe8b:9ed0/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:1128 errors:0 dropped:0 overruns:0 frame:0
          TX packets:891 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:120529 (120.5 KB)  TX bytes:100422 (100.4 KB)

eth1      Link encap:Ethernet  HWaddr 08:00:27:fe:1e:6f
          inet addr:192.168.33.33  Bcast:192.168.33.255  Mask:255.255.255.0
          inet6 addr: fe80::a00:27ff:fefe:1e6f/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:17 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:1586 (1.5 KB)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

      SHELL
    end
  end

  config.after(:each) do
    clearfs
  end
end

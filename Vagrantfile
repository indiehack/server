# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

# install needed plugins
['vagrant-triggers', 'vagrant-omnibus', 'vagrant-hostsupdater'].each do |plugin| 
  unless Vagrant.has_plugin?(plugin)
    system('vagrant plugin install '+ plugin) || exit!
    exit system('vagrant', *ARGV)
  end
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # TODO: this was fialing, why ?
  # config.vm.hostname = 'indiehack'

  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = 'latest'
  end

  config.vm.box = 'ubuntu/vivid64'


  cookbooks_path = 'cookbooks'
  # instead of berks plugin ...
  config.trigger.before [:up, :provision] , :stdout => true do
    info 'Cleaning cookbook directory'
    run "rm -rf #{cookbooks_path}"
    info 'Installing cookbook dependencies with berkshelf'
    run "berks vendor #{cookbooks_path}"
  end

  config.vm.synced_folder "../back", "/var/back"
  config.vm.synced_folder "../front", "/var/front"

  # Workaround for https://github.com/mitchellh/vagrant/issues/5199
  config.trigger.before [:reload, :up ], stdout: true do
    my_SYNCED_FOLDER = ".vagrant/machines/default/virtualbox/synced_folders"
    info "Trying to delete folder #{my_SYNCED_FOLDER}"
    begin
        File.delete(my_SYNCED_FOLDER)
    rescue StandardError => e
        warn "Could not delete folder #{my_SYNCED_FOLDER}. Nevermind :)"
        warn e.inspect
    end
  end


  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  #config.vm.network :private_network, type: 'dhcp'
  config.vm.network :private_network, ip: '192.168.44.44'

  if Vagrant.has_plugin?("vagrant-hostsupdater")
    #config.vm.hostname = "inha"
    config.hostsupdater.aliases = ['mongo.inha']
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
    # Don't boot with headless mode
    # vb.gui = true
  
    # more RAM #todo: move this to local config
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  # config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
      'recipe[indiehack::default]'
    ]
  end
end

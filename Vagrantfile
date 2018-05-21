$rds_gw = <<SCRIPT
 Write-host "Starting installation at:" (get-date) -ForegroundColor Cyan
 hostname
  tzutil /s "Central European Standard Time"
  Write-Host "Setting DNS server" 
  $adapter = Get-NetAdapter | ? {$_.Name -eq "Ethernet 2"}
  $adapter | Set-DnsClientServerAddress -ServerAddresses 192.168.33.10
  Write-Host "Finished Setting DNS server"
  Add-Computer -DomainName  corp.contoso.com -Credential corp\vagrant
 Write-host "Ending installation at:" (get-date) -ForegroundColor Cyan
SCRIPT

$rds_broker = <<SCRIPT
 Write-host "Starting installation at:" (get-date) -ForegroundColor Cyan
 hostname
 Write-host "Ending installation at:" (get-date) -ForegroundColor Cyan
SCRIPT

$rds_sessionhost1 = <<SCRIPT
 Write-host "Starting installation at:" (get-date) -ForegroundColor Cyan
 hostname
 Write-host "Ending installation at:" (get-date) -ForegroundColor Cyan
SCRIPT


Vagrant.configure("2") do |config|
  config.vm.define "dc1" do |dc1|
	  dc1.vm.box = "jarekole/win2012core"
	  dc1.vm.hostname = "dc1"
	  dc1.vm.network "private_network", ip: "192.168.33.10"
    # use the plaintext WinRM transport and force it to use basic authentication.
    # NB this is needed because the default negotiate transport stops working
    #    after the domain controller is installed.
    #    see https://groups.google.com/forum/#!topic/vagrant-up/sZantuCM0q4
	
	  dc1.winrm.transport = :plaintext
      dc1.winrm.basic_auth_only = true
	  dc1.vm.provider "virtualbox" do |vb|
		 vb.gui = true
		 vb.memory = "1024"
	     vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
	  end
	  dc1.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
	  dc1.vm.provision "reload"
	  dc1.vm.provision "shell", path: "scripts/provision.ps1", privileged: false	  
	end
end


Vagrant.configure("2") do |config|
  config.vm.define "gw1" do |gw1|
	  gw1.vm.box = "jarekole/win2012gui"
	  gw1.vm.hostname = "gw1"
	  gw1.vm.network "private_network", ip: "192.168.33.11"
	  gw1.vm.provider "virtualbox" do |vb|
		 vb.gui = true
		 vb.memory = "512"
	     vb.customize ["modifyvm", :id, "--cpuexecutioncap", "40"]
	  end
	  gw1.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
	  gw1.vm.provision "reload"
	  gw1.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
  end
  
  config.vm.define "broker1" do |broker1|
	  broker1.vm.box = "jarekole/win2012gui"
	  broker1.vm.hostname = "broker1"
	  broker1.vm.network "private_network", ip: "192.168.33.12"
	  broker1.vm.provider "virtualbox" do |vb|
		 vb.gui = true
		 vb.memory = "1024"
	     vb.customize ["modifyvm", :id, "--cpuexecutioncap", "30"]
	  end
	  broker1.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
	  broker1.vm.provision "reload"
	  broker1.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
  end

  config.vm.define "sessionhost1" do |sessionhost1|
	  sessionhost1.vm.box = "jarekole/win2012gui"
	  sessionhost1.vm.hostname = "sessionhost1"
	  sessionhost1.vm.network "private_network", ip: "192.168.33.13"
	  sessionhost1.vm.provider "virtualbox" do |vb|
		 vb.gui = true
		 vb.memory = "1024"
	     vb.customize ["modifyvm", :id, "--cpuexecutioncap", "30"]
	  end
	  sessionhost1.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
	  sessionhost1.vm.provision "reload"
	  sessionhost1.vm.provision "shell", path: "scripts/provision.ps1", privileged: false
   end
  
end

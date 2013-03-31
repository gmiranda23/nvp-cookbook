class Chef::Recipe::NVP

  def self.error
    puts "================================================================================"
    puts "Recipe Requirement Error - Nicira OpenVswitch packages not found"
    puts "To fix this error, place Nicira OpenVswitch packages in #{node['nvp']['ovs']['pkg_path']}"
    puts "================================================================================"
  end



  def self.checkpkg(pkgfile)
    unless !Dir.glob("#{pkgfile}*.deb").empty?
      self.error
      Chef::Application.fatal!("Nicira package not found at #{pkgfile}")
    end
  end


end

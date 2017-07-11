# Used for uninstalling old recipe for wkhtmltopdf
default['wkhtmltopdf']['version']     = '0.12.0'
default['wkhtmltopdf']['install_dir'] = '/usr/local/bin'
default['wkhtmltopdf']['lib_dir']     = ''

default['wkhtmltopdf-update']['major_version'] = '0.12'
default['wkhtmltopdf-update']['version'] = '0.12.2.1'

case node['platform_family']
when 'mac_os_x', 'mac_os_x_server'
  default['wkhtmltopdf-update']['dependency_packages'] = []
  default['wkhtmltopdf-update']['platform'] = 'macosx-10.9.1-x86_64'
when 'windows'
  default['wkhtmltopdf-update']['dependency_packages'] = []
  if node['kernel']['machine'] == 'x86_64'
    default['wkhtmltopdf-update']['platform'] = 'win64'
  else
    default['wkhtmltopdf-update']['platform'] = 'win32'
  end
else
  default['wkhtmltopdf-update']['dependency_packages'] = value_for_platform_family(
    %w(debian) => %w(libfontconfig1 libssl0.9.8 libxext6 libxrender1 fontconfig libjpeg8 xfonts-base xfonts-75dpi),
    %w(fedora rhel) => %w(fontconfig libXext libXrender openssl-devel urw-fonts)
  )
  if node['kernel']['machine'] == 'x86_64'
    default['wkhtmltopdf-update']['platform'] = 'linux-amd64'
    default['wkhtmltopdf-update']['package'] = value_for_platform_family(
      %w(debian) => "wkhtmltox-#{node['wkhtmltopdf-update']['version']}_linux-trusty-amd64.deb",
      %w(fedora rhel) => "wkhtmltox-#{node['wkhtmltopdf-update']['version']}_linux-centos6-amd64.rpm"
    )
  else
    default['wkhtmltopdf-update']['platform'] = 'linux-i386'
    default['wkhtmltopdf-update']['package'] = value_for_platform_family(
      %w(debian) => "wkhtmltox-#{node['wkhtmltopdf-update']['version']}_linux-trusty-i386.deb",
      %w(fedora rhel) => "wkhtmltox-#{node['wkhtmltopdf-update']['version']}_linux-centos6-i386.rpm")
  end
end

default['wkhtmltopdf-update']['mirror_url'] = "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/#{node['wkhtmltopdf-update']['version']}/#{node['wkhtmltopdf-update']['package']}"

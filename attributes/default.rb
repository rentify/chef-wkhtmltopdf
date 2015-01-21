default['wkhtmltopdf-update']['version']     = '0.12.2'

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
  else
    default['wkhtmltopdf-update']['platform'] = 'linux-i386'
  end
end

default['wkhtmltopdf-update']['package']     = "wkhtmltox-#{node['wkhtmltopdf-update']['version']}_linux-trusty-amd64.deb"
default['wkhtmltopdf-update']['mirror_url']  = "http://downloads.sourceforge.net/project/wkhtmltopdf/#{node['wkhtmltopdf-update']['version']}/#{node['wkhtmltopdf-update']['package']}"

package "postgresql-devel" do
  package_name value_for_platform(
    ["centos","redhat","fedora"] => {"default" => "postgresql-devel"},
    "amazon" => {"default" => "postgresql96-devel"},
    "ubuntu" => {"default" => "libpq-dev"}
  )

  action :install
end

package "postgresql-client" do
  package_name value_for_platform(
    ["centos","redhat","fedora"] => {"default" => "postgresql"},
    "amazon" => {"default" => "postgresql96"},
    "default" => "postgresql-client"
  )

  action :install
end

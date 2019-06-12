bash 'install-pip' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
  EOH
end

bash 'install-python-deps' do
  user 'root'
  code 'pip install docopt json2parquet'
end

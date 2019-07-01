bash 'install-rust' do
  user 'deploy'
  environment 'HOME' => '/home/deploy'
  cwd '/home/deploy'
  code 'curl https://sh.rustup.rs -sSf | sh -s -- -y'
end

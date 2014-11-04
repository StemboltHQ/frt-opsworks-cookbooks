service "awslogs" do
  supports :status => true, :restart => true
  action :nothing
end

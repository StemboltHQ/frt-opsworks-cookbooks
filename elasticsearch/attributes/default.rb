# #-*- encoding : utf-8 -*-
# === VERSION AND LOCATION
default.elasticsearch[:version]       = "0.90.3"
default.elasticsearch[:host]          = "http://download.elasticsearch.org"
default.elasticsearch[:repository]    = "elasticsearch/elasticsearch"
default.elasticsearch[:filename]      = "elasticsearch-#{node.elasticsearch[:version]}.tar.gz"
default.elasticsearch[:download_url]  = [node.elasticsearch[:host], node.elasticsearch[:repository], node.elasticsearch[:filename]].join('/')

# === USER & PATHS
default.elasticsearch[:dir]       = "/data"
default.elasticsearch[:user]      = "elasticsearch"
default.elasticsearch[:home_dir]  = [node.elasticsearch[:dir], node.elasticsearch[:user]].join('/')
default.elasticsearch[:command_path]  = [node.elasticsearch[:home_dir], 'bin', 'elasticsearch'].join('/')

default.elasticsearch[:path][:conf] = [node.elasticsearch[:home_dir], "config"].join('/')
default.elasticsearch[:path][:data] = [node.elasticsearch[:home_dir], "data"].join('/')
default.elasticsearch[:path][:plugins] = [node.elasticsearch[:home_dir], "plugins"].join('/')
default.elasticsearch[:path][:logs] = ['/var/log',node.elasticsearch[:user]].join('/')
default.elasticsearch[:path][:pids] = '/var/run'
default.elasticsearch[:pid_file]  = [node.elasticsearch[:path][:pids], "elasticsearch.pid"].join('/')

# === MEMORY
# Maximum amount of memory to use is automatically computed as one half of total available memory on the machine.
# You may choose to set it in your node/role configuration instead.
allocated_memory = "#{(node.memory.total.to_i * 0.6 ).floor / 1024}m"
default.elasticsearch[:allocated_memory] = allocated_memory

default.elasticsearch[:thread_stack_size] = "256k"

# === NODE
default.elasticsearch[:node][:name]    = "0"

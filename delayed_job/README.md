delayed_job Cookbook
====================
Configures delayed_job to work with monit.

Requirements
------------

Your Gemfile will require:

```ruby
gem 'delayed_job_active_record'
gem 'daemons'
```


Usage
-----
#### delayed_job::default
Just include `delayed_job` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[delayed_job]"
  ]
}
```

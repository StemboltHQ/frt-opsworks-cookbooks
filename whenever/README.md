whenever Cookbook
====================
Configures whenever to update crontab.

Requirements
------------
In order for cron to know how to find ruby, you need to provide it with the path environment variable. You can do so by including `env :path, ENV['PATH']` in your `schedule.rb` file.

Usage
-----
#### whenever::default
Just include `whenever` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[whenever]"
  ]
}
```

whenever Cookbook
====================
Configures whenever to update crontab.

Requirements
------------
In order for cron to know how to find ruby, you need to provide it with the path environment variable. You can do so by including the following line in your `schedule.rb` file:

`env :PATH, '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/aws/bin:/opt/aws/bin'`

Also, by default logging will be sent to syslog. If you want a filesystem logfile like rails generates, add the following line to `schedule.rb`:

`set :output, 'log/cron.log'`

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

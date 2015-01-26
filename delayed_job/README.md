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


Opsworks Usage
--------------

Simply add the `delayed_job::deploy` recipe to your deploy step.

This recipe generates the monit configuration in
`/etc/monit.d/APPLICATION_delayed_job.monitrc`, whenever this file changes, any
existing delayed_job process is stopped.

On each run `delayed_job` is restarted through monit.

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

Stack Settings
--------------

Delayed Job is configured through stack settings. Here are a few example
configurations.

Two processes running all queues.

```
{
  "deploy": {
    "myapp": {
      "delayed_job": [{
        "worker_count": 2
      }],
```

Two processes running jobs of different priorities

```
{
  "deploy": {
    "myapp": {
      "delayed_job": [
        {
          "identifier": "normal",
          "options": "--min-priority 0"
        },
        {
          "identifier": "priority",
          "options": "--max-priority -1"
        }
      ]
```


Two processes running jobs in different queues

```
{
  "deploy": {
    "myapp": {
      "delayed_job": [
        {
          "options": "--queue=priority"
        },
        {
          "options": "--queues=mail,tasks"
        }
      ]
```

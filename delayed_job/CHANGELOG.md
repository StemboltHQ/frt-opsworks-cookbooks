# CHANGELOG for delayed_job

This file is used to list changes made in each version of delayed_job.

## 0.1.0:

* Initial release of delayed_job

## 0.1.1:

* Monit now namespaces the delayed_job process. If you have an existing delayed_job running, there are a couple of things you'll need to do.
    1. Run the delayed_job::default recipe to create the new monit configuration file(s).
    2. Ensure the monit is correctly monitoring the new delayed_job processes.
    3. Unmonitor the old `delayed_job` process.
    4. Remove `/etc/monit.d/delayed_job.monitrc`
    5. Reload monit.

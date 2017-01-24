Filebeat Opsworks recipe
========================

Chef cookbook to install and configure filebeat service to send logs to remote
elasticache server

## Restrictions

This currently only works with Amazon Linux or other yum based distributions

## Sample Configuration

```
"filebeat": {
  "paths": ["/srv/www/app/shared/log/requests.log"],
  "hosts": ["host.us-east-1.aws.found.io:9243"],
  "protocol": "https",
  "username": "elastic",
  "password": "password-goes-here"
}
```

Recipes
------------------

`filebeat::default` install filebeat and restart service

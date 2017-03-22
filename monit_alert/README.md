monit_alert Cookbook
====================
Configures monit to send e-mails to a specified address.

Opsworks Usage
--------------

Simply add the `monit_alert::default` recipe to your setup step.

Stack Settings
--------------
```
  "monit_alert": {
    "email": "email@example.com",
    "smtp": {
      "server": "smtp.server.net",
      "username": "smtp_user@example.com",
      "password": "<password>",
      "hostname": "example.com
    }
  }
```

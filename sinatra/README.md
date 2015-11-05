# Sinatra Cookbook

This cookbook provides the necessary recipes to get a Sinatra app deployed on a
custom layer in AWS Opsworks. It requires a bit of custom JSON to get working.

## Usage

Create a custom layer in the AWS console as one normally would, and add the
following recipes at the following steps:

  - Setup: `ruby::default`, `sinatra::setup`
  - Configure: `sinatra::configure`
  - Deploy: `sinatra::deploy`

---

There's a bit of custom JSON you'll need for various things:

```javascript
{
  // Tell the bundler recipes we want to install bundler
  "opsworks_bundler": {
    "manage_package": "true"
  },

  "nginx": {
    // The unicorn socket is owned by `deploy` user with group `apache`.
    // We need nginx to match, otherwise upstream proxying fails.
    "user": "deploy apache"
  },

  // For our recipes, we expect the `application_type` to be `rack`.
  "deploy": {
    "my_app": {
      "application_type": "rack",
      "rack_env": "production"
    }
  }
}
```

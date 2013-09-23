image_optim Cookbook
====================
Installs optipng and pngcrush.

Requirements
------------
None

Usage
-----
#### image_optim::default
Just include `image_optim` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[image_optim]"
  ]
}
```

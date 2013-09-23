whenever Cookbook
====================
Configures whenever to update crontab.

Requirements
------------
None

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

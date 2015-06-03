# indiehack-cookbook

Cookbook and a vagrant file to run your node server environment.

## Prerequisities

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)
- [Chef-DK](https://downloads.chef.io/chef-dk/)

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['indiehack']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### indiehack::default

Include `indiehack` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[indiehack::default]"
  ]
}
```

## License and Authors

Author:: YOUR_NAME (<YOUR_EMAIL>)

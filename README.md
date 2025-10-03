# checks for check-config

This repo contains several checks which can be used by [check-config](https://check-config.readthedocs.io/en/latest/).

## Apply a single check

Check which changes are needed with:

```shell
check-config -p https://raw.githubusercontent.com/mrijken/checks/refs/heads/main/rerun/check-config.toml
```

Apply the changes:

```shell
check-config -p https://raw.githubusercontent.com/mrijken/checks/refs/heads/main/rerun/check-config.toml --file
```

## Use checks with a local check-config.toml

You can create a local `check-config.toml` file to include the snippets
of your liking:

```toml
include = [
  "https://raw.githubusercontent.com/mrijken/checks/refs/heads/main/rerun/check-config.toml"
]
```

With the next command you can check which fix are needed to make your system compliant
(with 0, 1 or 2 verbose options):

```shell
check-config -vv
```

And apply these to your system:

```shell
check-config --fix -vv
```

## Contribute

Do you have a snippet to share, please make a PR.

# checks for check-config

This repo contains several checks which can be used by [check-config](https://check-config.readthedocs.io/en/latest/).

You can create a local `check-config.toml` file to include the snippets
of your liking:

```toml
__include__ = [
  "https://raw.githubusercontent.com/mrijken/checks/refs/heads/main/bashrc/rerun.toml"
]
```

And apply these to your system:

```shell
check-config --fix
```

## Contribute

Do you have a snippet to share, please make a PR.

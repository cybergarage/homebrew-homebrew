# homebrew-homebrew

Homebrew tap repository for cybergarage.org.

```
brew tap cybergarage/homebrew
```

## Formulae

| Formula | Upstream |
|---|---|
| `mupnp` | [cybergarage/mupnp](https://github.com/cybergarage/mupnp) |
| `mupnp++` | [cybergarage/mupnp-cc](https://github.com/cybergarage/mupnp-cc) |
| `uecho` | [cybergarage/uecho](https://github.com/cybergarage/uecho) |
| `uhttp++` | [cybergarage/uhttp-cc](https://github.com/cybergarage/uhttp-cc) |

## Updating Formulae

Each formula can be updated to the latest release tag of its upstream GitHub repository with a single `make` command. The `update.sh` script fetches the latest tag, downloads the tarball, and rewrites the formula's `url` and `sha256`.

| Command | Description |
|---|---|
| `make update-dry` | Show which formulae would be updated, without changing any files |
| `make update` | Update all formulae to the latest tag |
| `make update-commit` | Update all formulae and commit each one as `Update <name> to <tag>` |

To update only specific formulae, pass their names with `FORMULA`:

```
make update FORMULA="uecho mupnp"
```

A typical release workflow:

```
make update-dry      # check what will change
make update-commit   # update and commit
git push
```

Notes:

- Only release tags such as `1.2.3` or `v1.2.3` are considered; pre-release tags are ignored.
- The upstream repository is taken from the formula's `url`, so the `url` must be a GitHub archive URL (`https://github.com/<owner>/<repo>/archive/...`). If an upstream repository is renamed, update the formula's `url` first.

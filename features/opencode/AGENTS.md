# Global agent instructions

## Shell tooling

When shelling out, prefer the modern replacements over the POSIX defaults.
Both are installed on every host managed by this config, but check with
`command -v` first if you are on an unfamiliar machine and fall back to the
default when the replacement is missing.

| Instead of | Use  | Notes                                                        |
| ---------- | ---- | ------------------------------------------------------------ |
| `find`     | `fd` | Respects `.gitignore`, skips hidden files, regex by default. |
| `grep`     | `rg` | Respects `.gitignore`, recursive by default, much faster.    |

Common translations:

```bash
find . -name '*.ts'        ->  fd -e ts
find . -type d -name node_modules  ->  fd -t d node_modules
find . -name '*.log' -delete       ->  fd -e log -X rm
grep -r "foo" .            ->  rg foo
grep -rn "foo" --include='*.py'    ->  rg foo -g '*.py'
grep -rl "foo" .           ->  rg -l foo
```

Caveats worth remembering:

- `fd` and `rg` skip ignored and hidden files by default. Add `-H`/`--hidden`
  and `-I`/`--no-ignore` when you genuinely need to search everything (e.g.
  inside `.git/`, `node_modules/`, or build output).
- `fd` matches against the file name, not the full path, unless you pass
  `-p`/`--full-path`.
- `fd`'s pattern is a regex, not a glob. Use `-g`/`--glob` for glob semantics.
- Neither tool follows symlinks unless given `-L`/`--follow`.

This preference is about the Bash tool only. For file discovery and content
search, the dedicated Glob and Grep tools are still the first choice — they are
already ripgrep-backed and cheaper than shelling out.

# KickNV

My lua neovim configuration.

### Keybindings to Remember

### Surrounding (e.g., with quotes)

Using **mini.surround** or similar:

- `sa{char}{char}` – surround a text object:
    - `sawq` → **S**urround **A**round **W**ord with **Q**uotes:
        - `saw"` → surrounds word with double quotes
        - `saw'` → surrounds word with single quotes
        - `saw)` → surrounds word with parentheses

> Think of it as:
> 
> - `s` – operator (`surround`)
> - `a` – motion target (like `aw`, `iw`)
> - `w` – word
> - `"` – what to surround with

### Delete inside something (like inside quotes)

- `di{char}` → **D**elete **I**nside `{char}`:
    - `di"` → delete inside double quotes
    - `di'` → delete inside single quotes
    - `di)` → delete inside parentheses

### Change inside something

- `ci"` → change inside quotes
- `ci(` → change inside parentheses
- `ci{}` → change inside curly brackets

### Memory Aids

| Keybinding | Meaning                       | Example                                                |
| ---------- | ----------------------------- | ------------------------------------------------------ |
| `di"`      | Delete inside quotes          | removes text inside `"`                                |
| `da'`      | Delete around quotes          | removes quotes + text                                  |
| `ci)`      | Change inside parentheses     | clears content inside `()` and puts you in insert mode |
| `saw"`     | Surround around word with `"` | turns `word` → `"word"`                                |


### Summary Cheat Sheet

| Action                 | Keybinding Example | Description                                |
| ---------------------- | ------------------ | ------------------------------------------ |
| Surround word          | `saw'`             | Surround a word with `'`                   |
| Delete inside quotes   | `di"`              | Delete text inside `"`                     |
| Change inside brackets | `ci(`              | Change text inside `(`                     |
| Visual inside quotes   | `vi"`              | Visually select inside `"`                 |
| Delete around word     | `daw`              | Delete a word including surrounding spaces |
| Change around quotes   | `ca'`              | Change text including surrounding quotes   |


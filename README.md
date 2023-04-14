# cursed.vim

> This plugin is no longer maintained. If you are using Neovim, there's a Lua
> version available at [filipekiss/cursed.nvim](https://github.com/filipekiss/cursed.nvim)

![Cursed example](https://user-images.githubusercontent.com/48519/64197116-89d63580-ce85-11e9-803d-554447ff3aee.gif)

## Install

Using [vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'filipekiss/cursed.vim'
```

## Usage

This plugins add two new User autocmds `CursedStartedMoving` and
`CursedStoppedMoving`. You can use the events to trigger commands after a delay
triggered after the cursor stops moving. For example, you can use to show
`cursorline` only when the cursor has been stopped for a while:

```vim
augroup CursedCursorLine
    autocmd!
    autocmd WinEnter * if !cursed#is_disabled() | set cursorline | endif
    autocmd User CursedStartedMoving :set nocursorline
    autocmd User CursedStoppedMoving :set cursorline
augroup END
```

If you have [nvim-blame-line][blameline], for example, you may do something
like this:

```vim
augroup CursedBlameLine
    autocmd!
    autocmd User CursedStoppedMoving silent :SingleBlameLine
augroup END
```

And the blame will appear after the timer runs out (as seen in the gif above).

## Settings

### `g:cursed_delay_ms`

How long after the `CursedStartedMoving` event the `CursedStoppedMoving` will be
triggered. The default value is the same as `updatetime`, unless this variable
is set.

### `b:cursed_disabled`

Disables the events for the current bufffer

### `g:cursed_disabled_filetypes`

An array of file types in which the events should not be triggered. The events
won't trigger in terminal buffers.

```viml
" default value
let g:cursed_disabled_filetypes = ['startify', 'fzf']
```

---

**cursed.vim** © 2019+, Filipe Kiss Released under the [MIT] License.<br>
Authored and maintained by Filipe Kiss.

> GitHub [@filipekiss](https://github.com/filipekiss) &nbsp;&middot;&nbsp;
> Twitter [@filipekiss](https://twitter.com/filipekiss)

[mit]: http://mit-license.org/
[blameline]: https://github.com/tveskag/nvim-blame-line

# cursed.vim

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

If you have [nvim-blame-line][blameline]<sup id="fnref-1">[1](#fn-1)</sup>, for
example, you may do something like this:

```vim
augroup CursedBlameLine
    autocmd!
    autocmd WinEnter,WinLeave * silent :DisableBlameLine
    autocmd User CursedStartedMoving silent :DisableBlameLine
    autocmd User CursedStoppedMoving silent :EnableBlameLine
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

> default value: let g:cursed_disabled_filetypes = ['startify', 'fzf']

--

##### Notes

<a name="fn-1">1</a>. This is a forked version that works with cursed.vim. The
[original version](https://github.com/tveskag/nvim-blame-line) would error when
ran against a `NO NAME` buffer. [← back](#fnref-1)

**cursed.vim** © 2019+, Filipe Kiss Released under the [MIT] License.<br>
Authored and maintained by Filipe Kiss.

> GitHub [@filipekiss](https://github.com/filipekiss) &nbsp;&middot;&nbsp;
> Twitter [@filipekiss](https://twitter.com/filipekiss)

[mit]: http://mit-license.org/
[blameline]: https://github.com/filipekiss/nvim-blame-line

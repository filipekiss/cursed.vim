if exists('g:loaded_cursed')
  finish
endif
let g:loaded_cursed = 1

let g:cursed_default_disabled_filetypes = ['startify', 'fzf']

let g:cursed_delay_ms = get(g:, 'cursed_delay_ms', &updatetime)

let g:cursed_disabled_filetypes = get(g:, 'cursed_disabled_filetypes', g:cursed_default_disabled_filetypes)

augroup CursedTimerCommands
  autocmd!
  autocmd CursorMoved,CursorMovedI * call cursed#cursor_moved()
  autocmd CmdWinEnter * let b:cursed_cmd_disabled = 1
  autocmd CmdWinLeave * let b:cursed_cmd_disabled = 0
augroup END

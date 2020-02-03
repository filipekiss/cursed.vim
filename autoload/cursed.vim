let s:idle = 0
let s:cursed_move_cursor = 1
let s:status = s:idle
let s:timer_id = 0

function! cursed#cursor_moved() abort
    if cursed#is_disabled()
        return
    endif
    call cursed#timer_stop()
    call cursed#timer_start()
    " Ensure the CursedStartedMoving event fires only once when the cursor
    " starts moving
    if s:status == s:cursed_move_cursor
        silent doautocmd <nomodeline> User CursedStartedMoving
        let s:status = s:idle
    endif
endfunction

function! cursed#timer_start() abort
    let s:timer_id = timer_start(g:cursed_delay_ms, 'cursed#timer_ended_callback')
endfunction

function! cursed#timer_stop() abort
    if s:timer_id
        call timer_stop(s:timer_id)
        let s:timer_id = 0
    endif
endfunction

function! cursed#timer_ended_callback(timer_id) abort
    if cursed#is_disabled()
        return
    endif
    " Reset the status to allow the CursedStartedMoving event to be fired again
    let s:status = s:cursed_move_cursor
    let s:timer_id = 0
    silent doautocmd <nomodeline> User CursedStoppedMoving
endfunction

function! cursed#is_disabled() abort
    return get(b:, 'cursed_cmd_disabled', 0) || &buftype ==# 'terminal' || mode() ==? 'c' || get(b:, 'cursed_disabled', 0) || cursed#hasFileType(g:cursed_disabled_filetypes)
endfunction

function! cursed#hasFileType(list)
    return index(a:list, &filetype) != -1
endfunction

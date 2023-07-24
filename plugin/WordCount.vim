
" WordCount.vim - Simple plugin for counting words in vim when writing file

" Configuration variables
let g:word_count_goal = 500  " Set the default word goal here

" Function to count the number of words in a given range (start, end).
function! s:count_words_in_range(start, end) abort
  let words = len(split(join(getline(a:start, a:end), ' '), '\s\+'))
  return words
endfunction

" Function to count the words in the entire buffer.
function! s:CountAllWords() abort
  let words = s:count_words_in_range(1, line("$"))
  return words
endfunction

" Function to count the words in a specified range or the entire buffer.
function! s:WordCountInRange() abort
  let [start_line, end_line] = [line("'<"), line("'>")]
  if start_line != end_line
    " If a range is selected in Visual mode, get the word count in the selection.
    return s:count_words_in_range(start_line, end_line)
  else
    return s:CountAllWords()
  endif
endfunction


" Function to set the word goal
function! s:SetWordGoal(word_goal) abort
  let trimmed_goal = trim(a:word_goal)
  if trimmed_goal =~# '^\d\+$'
    let g:word_count_goal = trimmed_goal
  else
    echo "Invalid input. Word goal not updated."
  endif
endfunction

" Function to show the floating window with word count
function! s:ShowFloatingWindow(word_count) abort
  if !exists('g:word_count_floating_window') && has('float')
    let l:float_win_id = popup_create([a:word_count], {
        \ 'line': 1,
        \ 'col': 0,
        \ 'minwidth': 0,
        \ 'minheight': 1,
        \ 'zindex': 1000,
        \ 'focusable': 0,
        \ 'border': [],
        \ 'padding': [0, 1, 0, 1],
        \ 'wrap': 0,
        \ 'scrollbar': 0,
        \ 'highlight': 'ErrorMsg',
        \ })
    let g:word_count_floating_window = l:float_win_id
  else
    call popup_settext(g:word_count_floating_window, [a:word_count])
  endif
endfunction

" Function to update the word count in the floating window
function! s:UpdateFloatingWindow() abort
  let words = s:WordCountInRange()
  let current_word_count = printf("%d/%d", words, g:word_count_goal)
  call s:ShowFloatingWindow(current_word_count)
endfunction

" Function to close the floating window
function! s:CloseFloatingWindow() abort
  if exists('g:word_count_floating_window') && popup_valid(g:word_count_floating_window)
    call popup_close(g:word_count_floating_window)
    unlet! g:word_count_floating_window
  endif
endfunction

" Define a command `WordCount` that invokes the `s:UpdateFloatingWindow()` function.
command! -range=% WordCount call s:UpdateFloatingWindow()

" Define a command `SetWordGoal` that invokes the `s:SetWordGoal()` function.
command! -nargs=1 SetWordGoal call s:SetWordGoal(<f-args>)

" Auto-update word count in the floating window when text changes
augroup word_countAutoUpdate
  autocmd!
  autocmd TextChanged,TextChangedI * if exists('g:word_count_floating_window') | call s:UpdateFloatingWindow() | endif
augroup END

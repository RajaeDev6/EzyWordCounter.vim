# EzyWordCounter.vim


EzyWordCounter.vim is a Vim plugin that allows you to easily track and toggle word
counts while writing essays or any other text in Vim. This plugin helps you
keep track of the number of words you have typed in the current buffer and can
be particularly useful when you have a specific word limit that you need to
reach.

## Features 
- **Word Count Tracking**: The plugin displays the current word count at the
  top of the screen in a floating window.
- **Toggle Functionality**: You can toggle the visibility of the word count
  window with a simple command.
- **Customizable Word Goal**: Easily set your desired word limit using the
  SetWordGoal command.
- **Convenient Commands**: Use the WordCount command to quickly check the
  current word count in the buffer.

## Installation

Using a plugin manager is the recommended way to install EzyWordCounter.vim. 
If you are using vim-plug, add the following line to your vimrc:

```vim 
Plug 'RajaeDev6/EzyWordCounter.vim' 
``` 
Then, reload your Vim configuration and run :PlugInstall to install the plugin.

## Usage

- **Set Word Goal**: To set a specific word limit, use the SetWordGoal command
  followed by the desired word count:

```
vim :SetWordGoal 1000
``` 

This will set the word goal to 1000 words.

- **Check Word Count**: To check the current word count in the buffer, use the
  WordCount command:

```
vim :WordCount
```

- **Keymap**: you can also set keymaps to activate the word count by doing

```
vim nnoremap <leader>wc :WordCount<CR>
```

## LICENSE 

This plugin is licensed under the MIT [License](./LICENSE). Feel free to modify
and distribute it according to the terms of the license.


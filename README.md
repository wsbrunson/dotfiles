## How To Use
`stow -t ~/ stow`
`mise install`

## Project Worflow
### In iTerm, create new tab for project
cd ~/my-project

### Start tmux session
tmux new-session -d -s myproject

### Create your three windows
tmux new-window -t myproject -n lazygit 'lazygit'
tmux new-window -t myproject -n vim 'vim'
tmux new-window -t myproject -n claude 'claude-code'

### Attach to session
tmux attach -t myproject

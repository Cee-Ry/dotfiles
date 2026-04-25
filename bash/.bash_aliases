# .bash_aliases

# Multi way to use nvim
alias nano='nvim'
alias vi='nvim'
alias vim='nvim'

# Compiling
alias CCPP='g++ source/*.cpp -o main && clear && ./main'
alias CCPP1='g++ *.cpp -o main && clear && ./main'
alias CMAKE='(mkdir -p build && cd build && cmake .. && make && ./snake)'

# Shortcuts commnad
alias push='git push -u origin main'
alias lsa='ls -ahlp'
alias ls='ls -ap1'

# Application
alias gdm-settings='flatpak run io.github.realmazharhussain.GdmSettings'
alias ToDRLA='(cd ~/.phg/ToDRLA/nwjs && ./nw ..)'

# Local AI
alias AI='./build/bin/llama-cli \
  -m ./models/qwen2.5-coder-7b-q4.gguf \
  -t 8 \
  --ctx-size 4096 \
  --conversation'
alias ai='~/Documents/Github/llama.cpp/build/bin/llama-cli \
  -m ~/Documents/Github/llama.cpp/models/qwen2.5-coder-7b-q4.gguf \
  -t 8 \
  --ctx-size 4096 \
  --conversation'

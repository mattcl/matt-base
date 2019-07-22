default['matt-base']['users']['matt'] = {
  # overwrite this default password (test1234)
  'password' => '$6$P.HAXLxiJIXdxG$qJ9k/zZbDpsHyADS8t1ngrKWp8nLcTR/qy/tcT484UxwoOdr/Ky7VM.S5YL5Q09wBohP3tbVoFl6U3AjDW/UE0', # rubocop:disable Metrics/LineLength
  'sudo' => true,
  'shell' => '/bin/zsh'
}

# packages
default['matt-base']['packages']['installed'] = {
  'asciinema'         => nil,
  'exuberant-ctags'   => nil,
  'gcc'               => nil,
  'goaccess'          => nil,
  'htop'              => nil,
  'jq'                => nil,
  'libevent-dev'      => nil,
  'libncurses5-dev'   => nil,
  'libperl-dev'       => nil,
  'libreadline-dev'   => nil,
  'libssl-dev'        => nil,
  'libx11-dev'        => nil,
  'libxpm-dev'        => nil,
  'libxt-dev'         => nil,
  'lnav'              => nil,
  'lua5.1'            => nil,
  'lua5.1-dev'        => nil,
  'make'              => nil,
  'ncurses-base'      => nil,
  'perl'              => nil,
  'python3-distutils' => nil,
  'ruby-dev'          => nil,
  'shellcheck'        => nil,
  'thefuck'           => nil,
  'tree'              => nil,
  'vim'               => nil,
  'yank'              => nil,
  'zlib1g-dev'        => nil,
}

default['matt-base']['ripgrep']['url'] =
  'https://github.com/BurntSushi/ripgrep/releases/download/0.5.0/ripgrep-0.5.0-x86_64-unknown-linux-musl.tar.gz' # rubocop:disable Metrics/LineLength

default['matt-base']['tmux']['url'] =
  'https://github.com/tmux/tmux/releases/download/2.0/tmux-2.0.tar.gz'

default['matt-base']['oh-my-zsh']['url'] =
  'https://github.com/robbyrussell/oh-my-zsh.git'

default['matt-base']['oh-my-zsh']['additional_plugins'] = {
  'fzf-marks' => {
    'url' => 'https://github.com/urbainvaes/fzf-marks.git'
  },
  'syntax-highlighting' => {
    'url' => 'https://github.com/zsh-users/zsh-syntax-highlighting.git'
  },
  'vi-mode-custom' => {
    'url' => 'https://github.com/mattcl/vi-mode-custom.git'
  },
  'virtualenv-mod' => {
    'url' => 'https://github.com/mattcl/virtualenv-mod.git'
  },
}

default['matt-base']['fzf']['url'] =
  'https://github.com/junegunn/fzf.git'

# python
default['matt-base']['python3']['version'] = '3.6'
default['matt-base']['python3']['pip_version'] = '9.0.1'
default['matt-base']['python3']['setuptools_version'] = '23.1.0'
default['matt-base']['python3']['packages'] = {
  'clustershell'      => nil,
  'virtualenv'        => nil,
  'virtualenvwrapper' => nil,
}

# ruby
default['matt-base']['ruby']['versions']['2.4.1']['enabled'] = true
default['matt-base']['ruby']['versions']['2.4.1']['gems'] = {
  'tmuxinator' => nil
}

default['matt-base']['ruby']['global_version'] = '2.4.1'
default['matt-base']['rbenv']['users']['matt'] = true

# powerline fonts
default['matt-base']['powerlinefonts']['font'] =
  'https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf'
default['matt-base']['powerlinefonts']['config'] =
  'https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf' # rubocop:disable Metrics/LineLength

# vim
default['matt-base']['vim']['configuration'] = ' --prefix=/usr/local --with-features=huge --enable-rubyinterp --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-luainterp --enable-tclinterp --enable-cscope --enable-fontset --enable-multibyte --enable-largefile' # rubocop:disable Metrics/LineLength
default['matt-base']['vim']['ycm_install_flags'] = ''
default['matt-base']['vim']['config_repo'] = 'https://github.com/mattcl/.vim.git'
default['matt-base']['vim']['vundle_repo'] = 'https://github.com/VundleVim/Vundle.vim.git' # rubocop:disable Metrics/LineLength

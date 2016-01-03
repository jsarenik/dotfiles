export GOPATH=$HOME/go

PATH=$PATH:$GOPATH/bin
export PATH=$HOME/bin:$PATH

BASHRC=$HOME/.bashrc
test -r $BASHRC && . $BASHRC

export FT2_SUBPIXEL_HINTING=1

# https://wiki.archlinux.org/index.php/Apple_Keyboard#Function_keys_do_not_work
sudo sh -c "echo 2 > /sys/module/hid_apple/parameters/fnmode"

export BROWSER=firefox
export EDITOR=vi
export VISUAL=vi

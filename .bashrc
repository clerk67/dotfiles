powerline-daemon -q
source /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh

export GOOGLE_APPLICATION_CREDENTIALS=
export MANPAGER='/bin/bash -c "vim -MRn -c \"set ft=man nomod nolist nospell nonu\" -c \"nm q :qa!<CR>\" -c \"nm <end> G\" -c \"nm <home> gg\"</dev/tty <(col -b)"'

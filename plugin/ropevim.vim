if !has("python")
    finish
endif

function! LoadRope()
python << EOF
import vim
import sys
import os

SUBMODULES = ['rope', 'ropemode']
BASE_DIR = vim.eval("g:RopeVimDirectory")
for module in SUBMODULES:
    module_dir = os.path.join(BASE_DIR, module)
    if module_dir not in sys.path:
        sys.path.insert(0, module_dir)

sys.path.insert(0, vim.eval("g:RopeVimDirectory"))
import ropevim
from rope_omni import RopeOmniCompleter
EOF
endfunction

if !exists("g:RopeVimDirectory")
  let g:RopeVimDirectory = expand('<sfile>:p:h')
  call LoadRope()
endif

" The code below is an omni-completer for python using rope and ropevim.
" Created by Ryan Wooden (rygwdn@gmail.com)

function! RopeCompleteFunc(findstart, base)
    " A completefunc for python code using rope
    if (a:findstart)
        py ropecompleter = RopeOmniCompleter(vim.eval("a:base"))
        py vim.command("return %s" % ropecompleter.start)
    else
        py vim.command("return %s" % ropecompleter.complete(vim.eval("a:base")))
    endif
endfunction

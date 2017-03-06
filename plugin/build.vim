" =============================================================================
" Filename:     plugin/build.vim
" Author:       luzhlon
" Function:     使用scons构建C/C++程序的插件
" Last Change:  2017/3/5
" =============================================================================

if has('win32')
py3 << EOF
import subprocess
g_si = subprocess.STARTUPINFO()
g_si.dwFlags = subprocess.STARTF_USESHOWWINDOW
g_si.wShowWindow = subprocess.SW_HIDE
g_encoding = 'gbk'
EOF
else
py3 g_si = None; g_encoding = 'utf-8'
endif
py3 << EOF
import subprocess
from subprocess import PIPE
import threading
import time
class Process(subprocess.Popen):
    bufsize = 1024
    def __init__(self, cmd, **args):
        args.update({'stdin': PIPE, 'stdout': PIPE, 'stderr': PIPE})
        super(Process, self).__init__(cmd, **args)
    def read(self, callback):
        '''启动一个线程循环读取输出，并传递给回调函数'''
        def foo():
            while 1:
                l = self.stdout.read(Process.bufsize)
                if not l and not self.alive():
                    self.on_quit(self);break
                callback(self, l.decode(encoding=g_encoding, errors='replace'))
        threading.Thread(target=foo).start()
    def readline(self, callback):
        '''启动一个线程循环读取一行输出，并传递给回调函数'''
        def foo():
            while 1:
                l = self.stdout.readline()
                if not l and not self.alive():
                    self.on_quit(self);break
                callback(self, l.decode(encoding=g_encoding, errors='replace'))
        threading.Thread(target=foo).start()
    def on_quit(self):
        pass
    def write(self, data):
        '''向标准输入里写入一段数据'''
        if type(data) is str:
            data = data.encode()
        self.stdin.write(data)
    def exec(self, data):
        '''向标准输入里写入一行命令'''
        self.write(data)
        self.stdin.write(b'\n')
        self.stdin.flush()
    def alive(self):
        '''判断子进程是否存活'''
        return self.poll() == None
EOF

fun! RunTask(cmd, ...)
py3 p = Process(vim.eval('a:cmd'), startupinfo = g_si)
if a:0 > 0
    py3 _output = vim.Function(vim.eval('a:1'))
    py3 p.readline(lambda p, l: _output(l))
endif
if a:0 > 1
    py3 _quit = vim.Function(vim.eval('a:2'))
    py3 p.on_quit = lambda p: _quit(str(p.returncode))
endif
endf

fun! s:onout(l)
    cadde a:l
    redraw
endf
fun! s:onquit(exitcode)
    let code = 0 + a:exitcode
    if code
        if exists('g:run_on_failure')
            exe g:run_on_failure
        else
            cwindow
        endif
    elseif exists('g:run_on_success')
        exe g:run_on_success
    endif
endf

fun! s:Run(cmd)
    if empty(a:cmd)|return|endif
    let cmd = join([&shell, &shcf, a:cmd])
    cexpr ''
    call RunTask(cmd, 's:onout', 's:onquit')
endf

com! -nargs=* -complete=shellcmd RunTask call <SID>Run('<args>')

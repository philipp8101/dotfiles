from i3ipc import Connection, Event
import sys

i3 = Connection()

display = ["DP-2", "DP-0", "HDMI-0"]

def get_output(ws):
    for i in ws :
        if i.focused:
            return i.output

def get_current_ws_for_output(output):
    for i in i3.get_outputs():
        if i.name == output:
            return i.current_workspace
def get_ws(name):
    for i in i3.get_workspaces(): 
        if i.name == name:
            return i

def get_ws_con(name):
    for i in i3.get_tree():
        if i.name == name:
            return i

arg = sys.argv[1]
focused_ws = display.index(get_output(i3.get_workspaces()))
ws = 0
dir = ''
dir_inv = ''
if arg == 'right':
    ws = focused_ws + 1 % 3
    dir = 'right'
    dir_inv = 'left'
if arg == 'left':
    ws = focused_ws - 1 % 3
    dir = 'left'
    dir_inv = 'right'

swap = get_ws_con(get_current_ws_for_output(display[ws]))
main = get_ws_con(get_current_ws_for_output(display[focused_ws]))
swap.command('move workspace to output '+dir_inv)
main.command('move workspace to output '+dir)
main.command('focus')

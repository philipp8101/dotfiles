#!/usr/bin/python
import i3ipc
import sys

title = sys.argv[1]
if not title: 
    sys.exit(1)

i3 = i3ipc.Connection()

def find_window_by_title(target_title):
    for window in i3.get_tree().leaves():
        if window.window_title and target_title in window.window_title :
            return window.id
    sys.exit(2)

i3.command('[con_id={}] focus'.format(find_window_by_title(title)))


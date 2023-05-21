#!/usr/bin/python
import i3ipc

i3 = i3ipc.Connection()


def find_focued_workspace():
    focused = i3.get_tree().find_focused()
    for i in i3.get_tree().nodes:
        result = i.find_by_id(focused.id) 
        if result:
            return i.name

target = find_focued_workspace()
if target:
    print(target)
    i3.command("[con_mark={}] focus".format(target))

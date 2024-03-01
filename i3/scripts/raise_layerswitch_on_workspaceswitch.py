#!/usr/bin/env python3

from i3ipc import Connection, Event

def on_workspace(i3, e):
    # broken
    # switch_raise_layers(i3, e)
    i3.command('unmark insert')
    


def switch_raise_layers(i3, e):
    if (e.current.name == "29:S" or e.current.name == "30:T"):
        f = open("/dev/ttyACM0", "a")
        f.write("layer.moveTo 7")
        f.close()
    else:
        f = open("/dev/ttyACM0", "a")
        f.write("layer.moveTo 0")
        f.close()
    i3.command('unmark insert')


i3 = Connection()
i3.on(Event.WORKSPACE, on_workspace)
i3.main()

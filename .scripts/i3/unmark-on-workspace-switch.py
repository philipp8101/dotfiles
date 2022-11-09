#!/usr/bin/env python3

from i3ipc import Connection, Event

def on_workspace(i3, e):
    i3.command('unmark insert')
i3 = Connection()
i3.on(Event.WORKSPACE, on_workspace)
i3.main()

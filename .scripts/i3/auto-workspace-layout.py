#!/usr/bin/env python3
#
from i3ipc import Event

def on_workspace(i3, e):
    await i3.command('unmark insert')
i3.on(Event.WORKSPACE, on_workspace)

await i3.main()

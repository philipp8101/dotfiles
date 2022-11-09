#!/usr/bin/python3
from i3ipc import Connection, Event
def callback(i3,e):
    if e.change == 'focus':
        f = open('/tmp/i3-lastfocus','w') # apparently id change between calls ?
        f.write(str(e.container.id))
        f.close()
        print('focused updated')
    if e.change == 'new':
        l = i3.get_tree().find_by_id(e.container.id).workspace().leaves()
        f = open('/tmp/i3-lastfocus','r')
        lastfocus = i3.get_tree().find_by_id(f.read()).id
        for i in l :
            print(i.id)
        # if len(l) > 2:
            # e.container.command('splitv')
            # l[1].command('mark tmp')
            # l[2].command('move container to mark tmp')
            # l[2].command('unmark tmp')
i3 = Connection()
i3.on('window',callback)
i3.main()

import signal
from i3ipc import Connection, Event
i3 = Connection()

def on_workspace(i3, e):
    i3.command('unmark insert')
    old_screen_name = find_screeen_of_worksapce(e.old)
    new_screen_name = find_screeen_of_worksapce(e.current)
    if old_screen_name and new_screen_name and old_screen_name == new_screen_name:
        e.old.command("mark --add "+old_screen_name)

i3.on(Event.WORKSPACE, on_workspace)

def find_screeen_of_worksapce(target):
    if target and target.id:
        for i in i3.get_tree().nodes:
            result = i.find_by_id(target.id) 
            if result:
                return i.name


def signal_handler(signal, frame):
    print(f"Received signal: {signal}")

for sig in signal.Signals:
    try:
        signal.signal(sig, signal_handler)
        print(f"Signal handler set for {sig.name}")
    except Exception as e:
        print(f"Skipping signal {sig.name} (not supported)")


i3.main()

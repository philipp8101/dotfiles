import i3ipc

i3 = i3ipc.Connection()


def find_focued_monitor():
    focused = i3.get_tree().find_focused()
    for i in i3.get_tree().nodes:
        result = i.find_by_id(focused.id) 
        if result:
            return i

target = find_focued_monitor()
if target:
    ws_name = i3.get_tree().find_marked(target.name)[0].name
    if ws_name:
        i3.command("workspace {}".format(ws_name))

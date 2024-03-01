#!/usr/bin/python

import os
from sys import argv
import subprocess
from time import sleep
from i3ipc import Connection
mode = os.environ["mode"] if "mode" in os.environ else None
recall = os.environ["recall"] if "recall" in os.environ else None
choice = argv[1] if len(argv) > 1 else None


ws_number = ["1","2","3","4","5","6","7","8","9","10"]
ws_named = ["11:A","12:B","13:C","14:D","15:E","16:F","17:G","18:H","19:I","20:J","21:K","22:L","23:M","24:N","25:O","26:P","27:Q","28:R","29:S","30:T","31:U","32:V","33:W","34:X","35:Y","36:Z"]
new_ws_identifier = "new workspace"
ws_names = ws_number + ws_named

tree = list(map(lambda x: x.name,Connection().get_workspaces()))
combined = ws_names+tree


def print_all_ws_names():
    print(new_ws_identifier)
    for i in list(tree+list(set(ws_names).difference(set(tree)))):
        print(i.split(":")[1] if ":" in i else i)


if choice == None and recall == None:
    print_all_ws_names()
else:
    if recall:
        sleep(1)
        output = subprocess.check_output("i3-input | grep output|grep -oP '(?<== ).*'",shell = True).decode('utf-8').strip()
        choice = "37:"+output

    if choice.isalpha() and not recall:
        for idx,i in reversed(list(enumerate(combined))):
            if i.find(choice) != -1:
                choice = combined[idx]
    for i in mode.split("-"):
        subprocess.call(['i3-msg', i, choice], stdout=subprocess.DEVNULL)

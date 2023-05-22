#!/usr/bin/python

from os import environ
from sys import argv
import subprocess
from i3ipc import Connection
mode = environ["mode"]
choice = argv[1] if len(argv) > 1 else None


ws_names = ["1","2","3","4","5","6","7","8","9","10","11:A","12:B","13:C","14:D","15:E","16:F","17:G","18:H","19:I","20:J","21:K","22:L","23:M","24:N","25:O","26:P","27:Q","28:R","29:S","30:T","31:U","32:V","33:W","34:X","35:Y","36:Z"]

tree = list(map(lambda x: x.name,Connection().get_workspaces()))
if choice == None:
    for i in list(tree+list(set(ws_names).difference(set(tree)))):
        print(i.split(":")[1] if ":" in i else i)
else:
    combined = ws_names+tree
    if choice.isalpha():
        for idx,i in reversed(list(enumerate(combined))):
            if i.find(choice) != -1:
                choice = combined[idx]
    for i in mode.split("-"):
        subprocess.call(['i3-msg', i, choice], stdout=subprocess.DEVNULL)

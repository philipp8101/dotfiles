#!/usr/bin/python3

import json, subprocess

output = subprocess.check_output(['i3-msg', '-t', 'get_workspaces'])
workspaces = json.loads(output)

a = ["1","2","3","4","5","6","7","8","9","10","11:A","12:B","13:C","14:D","15:E","16:F","17:G","18:H","19:I","20:J","21:K","22:L","23:M","24:N","25:O","26:P","27:Q","28:R","29:S","30:T","31:U","32:V","33:W","34:X","35:Y","36:Z"]
x = range(1,36)
next_num = next(i for i in x if not [ws for ws in workspaces if ws['num'] == i])

subprocess.call(['i3-msg', 'move container to workspace number %s,' % a[next_num - 1], 'workspace number %s' % a[next_num - 1]])
# subprocess.call(['i3-msg', 'workspace number %s' % a[next_num - 1]])


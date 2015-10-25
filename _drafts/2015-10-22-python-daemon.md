---
layout: post
title: Daemons and python

date: 2015-10-22 15:00:00 +0400

excerpt: |
    Build a basic daemon in python
---


```python
#! /usr/bin/env python

import argparse
import os
import signal

from daemon import DaemonContext
from daemon.pidfile import PIDLockFile


shutdown_requested = False


def request_shutdown(signum, frame):
    """
    Use this to request the daemon to shutdown.
    """

    global shutdown_requested
    shutdown_requested = True


def daemon_work(interactive: bool=False):
    pass


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    # setup our subparser for start, stop, restart
    sp = parser.add_subparsers(
        dest="daemon_control",
        title="daemon_control",
    )
    sp.required = True
    sp_start = sp.add_parser('start', help="start the daemon")
    sp_stop = sp.add_parser('stop', help="stop the daemon")
    sp_restart = sp.add_parser('restart', help="restart the daemon")

    # allow for an "interactive" flag
    parser.add_argument(
        "--interactive",
        help="run the daemon interactively",
        action="store_true",
    )

    args = parser.parse_args()

    # Setup daemon context
    cwd = os.path.dirname(os.path.abspath("__file__"))
    pid_path = "{}/daemon.pid".format(cwd)

    context = DaemonContext(
        working_directory=cwd,
        pidfile=PIDLockFile(pid_path),
        signal_map={
            signal.SIGTERM: request_shutdown,
        },
    )

    if args.daemon_control == 'start':
        print("Starting daemon ...")

    if args.daemon_control == 'stop':
        print("Stopping daemon ...")

    if args.daemon_control == 'restart':
        print("Restarting daemon ...")
```

```bash
$ ./daemon.py --help
usage: daemon.py [-h] [--interactive] {start,stop,restart} ...

optional arguments:
  -h, --help            show this help message and exit
  --interactive         run the daemon interactively

daemon_control:
  {start,stop,restart}
    start               start the daemon
    stop                stop the daemon
    restart             restart the daemon
```

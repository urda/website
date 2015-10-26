---
layout: post
title: Daemons and python

date: 2015-10-22 15:00:00 +0400

excerpt: |
    Build a basic daemon in python
---

## Full Source

```python
#! /usr/bin/env python

import argparse
import os
import signal
import sys

from daemon import DaemonContext
from daemon.pidfile import PIDLockFile


shutdown_requested = False
daemon_dir = os.path.dirname(os.path.abspath("__file__"))
log_path = "{}/daemon.log".format(daemon_dir)
pid_path = "{}/daemon.pid".format(daemon_dir)


def request_shutdown(signum, frame):
    """
    Use this to request the daemon to shutdown.
    """

    global shutdown_requested
    shutdown_requested = True


def daemon_work(interactive: bool=False):
    import time

    while True:
        time.sleep(1)

        if shutdown_requested:
            break


def start_daemon(interactive: bool=False):
    pass


def stop_daemon():
    pass


def restart_daemon():
    stop_daemon()
    # Pid file check attempts here
    start_daemon()


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
    context = DaemonContext(
        working_directory=daemon_dir,
        pidfile=PIDLockFile(pid_path),
        signal_map={
            signal.SIGTERM: request_shutdown,
        },
    )

    if args.daemon_control == 'start':
        print("Starting daemon ...")

        if args.interactive:
            pass
        else:
            with context:
                daemon_work(interactive=False)

    if args.daemon_control == 'stop':
        print("Stopping daemon ...")

        with open(pid_path, mode='r') as open_pid_file:
            pid_value = int(open_pid_file.readline().strip())

        os.kill(pid_value, signal.SIGTERM)

    if args.daemon_control == 'restart':
        if args.interactive:
            print("Interactive mode is not supported with restarts")
            sys.exit(1)

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

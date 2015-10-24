---
layout: post
title: Straightforward daemons in python

date: 2015-10-22 15:00:00 +0400

excerpt: |
    Build a basic daemon in python
---


```python
#! /usr/bin/env python

import argparse


shutdown_requested = False


def request_shutdown(signum, frame):
    """
    Use this to request the daemon to shutdown.
    """

    global shutdown_requested
    shutdown_requested = True


if __name__ == '__main__':
    parser = argparse.ArgumentParser()

    # setup our subparser for start, stop, restart
    sp = parser.add_subparsers(dest="command")
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
```

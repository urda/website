#! /usr/bin/env python

import argparse
import os
import signal
import sys

from daemon import DaemonContext
from daemon.pidfile import PIDLockFile


# Establish some global variables for the daemon
shutdown_requested = False
daemon_dir = os.path.dirname(os.path.realpath(sys.argv[0]))
log_path = "{}/daemon.log".format(daemon_dir)
pid_path = "{}/daemon.pid".format(daemon_dir)


def request_shutdown(signum, frame):
    """
    Use this to request the daemon to shutdown.
    """

    global shutdown_requested
    shutdown_requested = True


def daemon_work(interactive: bool=False):
    """
    The actual daemon workload.
    """

    import time

    while True:
        time.sleep(1)

        if shutdown_requested:
            break


def start_daemon(interactive: bool=False):
    # still do not like these methods
    pass


def stop_daemon():
    # remove me? 
    pass


def restart_daemon():
    stop_daemon()
    # PID file check attempts here
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
    sp_status = sp.add_parser('status', help="get the daemon's status")

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

    if args.daemon_control == 'status':
        pass

# Shell tapping

## Background

In order to create and setup the configurations used, the connection between
the app and access point were tapped into to reverse engineer the communication.

Originally, SSH man in the middle attack was considered
(the app does not appear to perform SSH key validation)
but this was discounted due to the complexity/security implications
of installing ~broken~ _altered_ SSH tools on the management device.
(both my dev laptops were busy compiling different distributions of linux at the time).

## Shell

Instead a tap was made by creating a new login shell `/bin/tsh`.
This shell is a script that logs the calling arguments before
running the default shell and logging any command output using tee.

Input logging was attempted but resulted in SSH login breaking.
It was not found to be required as the app ran all commands via arguments over ssh.

## Logging

Originally these outputs were logged to files on the access point.
As the access point does not (by default) run persistent storage, these are lost on reboot.

In order to persist logs and allow easier analysis, the scripts were altered
to push output over the network to be recorded on the management device.

As it transpires, the app does not reboot the access point after configuing (it restarts all the services instead).

## Usage

These tools contain network details such as IPs/ports hardcoded into the scripts.
These will need editing to be appropriate to the environment in order to be used.

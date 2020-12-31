# Ubiquiti Unifi wireless access point configuration

## Background

Ubiquiti manufacture high quality networking equipement.
Unfortunately, their wireless access points are only available in the Unifi line
designed to integrate to their enterprise network management/configuration tools.
This is inconvenient for setting up a single access point for SOHO environments.

Unify used to make an app (included in repo) that could set up access points in a standalone configuration mode.
Unfortunately it appears that the recent releases of this application
(from the play store) no longer support this configuration method.

Both the Unifi configuration system and the old app use SSH to
set up configuration files and run commands to set up the access point.

## Usage

running the `./setup.sh` script will generate configuration files from the templates included.
Prompts will be made to set up the wireless SSID and PSK and the username/password of the SSH admin user.
These files will be copied by SCP to the access point and stored to persistent memory.
The access point will be rebooted to commence using the new config.

The templates provided set up both bands (2.4/5GHz) with a single SSID and band steering configured.
The LED status light is set to turn off once successfully booted/operating correctly.
These settings could be altered with appropriate configuration of the template files.

## Investigation method

The configuration and setup commands used were determined by reverse engineering the Unifi app.
This was achieve with the shell tap utilities in the provided subdirectory.

## Miscellaneous

### Password hash

Upon factory reset, the access point is configured with a password
hashed using the original (DES) unix crypt(c) function.
The application creates password using scheme 1 (MD5) password hashing.
While these are unlikely to offer a material security vulnerability,
security best practice is to use modern stronger password hash functions.
It has been determined that the model/firmware used
by the author supports scheme 5 (SHA256) and 6 (SHA512).
The script is set up to run scheme 6.

### Files

Most of the configuration is in the .cfg file that is burnt to configuration.
The ordering in this file does not appear to be significant as the contents
appear to be run through unix `sort` prior to writing to storage.

Additionally the mgmt configuation file is placed in `/etc/persistent/cfg/` persistent directory.
This file is needed to set the status LED.

## Further work

### Config

Further investigation could be productive to more fully understand
the impact of different areas/options of the configuration files.
The provided config (as created by the app) appears to setup 3 wireless configurations for the 2 bands.
It is unclear whether this is required for the band steering or if it could be simplified futher.

Different/more sophisicated configurations could be supported
with appropriate understanding of the configuration syntax.

### Commands

Additional command line scripts exist on the Unifi access point that
offer additional functionality not covered by the tooling used.

The `syswrapper.sh` script appears to contain a large number of potentially useful subcommands.
The `set-locate` and `unset-locate` subcommands were used by the app to cause the status LED to blink.

Spectrum scanning functionality was found non-functional in the version of the app used
but may be supported with appropriate on-device configuration.

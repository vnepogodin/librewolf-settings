# Firejail profile for librewolf
# Description: Safe and easy web browser from Mozilla
# This file is overwritten after every install/update
# Persistent local customizations
include librewolf.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.cache/mozilla
noblacklist ${HOME}/.librewolf

mkdir ${HOME}/.cache/librewolf
mkdir ${HOME}/.librewolf
whitelist ${HOME}/.cache/librewolf
whitelist ${HOME}/.librewolf

whitelist /usr/share/mozilla
include whitelist-usr-share-common.inc

# librewolf requires a shell to launch on Arch.
#private-bin librewolf,which,sh,dbus-launch,dbus-send,env,bash
# private-etc must first be enabled in librewolf-common.profile
#private-etc librewolf

# Redirect
include librewolf-common.profile

# Firejail profile for librewolf-nightly
# Description: Safe and easy web browser from Mozilla
# This file is overwritten after every install/update
# Persistent local customizations
include librewolf-nightly.local
# Persistent global definitions
include globals.local

noblacklist ${HOME}/.cache/librewolf
noblacklist ${HOME}/.librewolf

mkdir ${HOME}/.cache/librewolf
mkdir ${HOME}/.librewolf
whitelist ${HOME}/.cache/librewolf
whitelist ${HOME}/.librewolf

# Uncomment (or add to librewolf-nightly.local) the following lines if you want to
# use the migration wizard.
#noblacklist ${HOME}/.mozilla
#whitelist ${HOME}/.mozilla

# librewolf-nightly requires a shell to launch on Arch. We can possibly remove sh though.
#private-bin bash,dbus-launch,dbus-send,env,librewolf-nightly,python*,sh,which
# private-etc must first be enabled in librewolf-nightly-common.profile
#private-etc librewolf-nightly

# Redirect
include librewolf-nightly-common.profile

#!/bin/bash

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/server/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

# Required
# SERVER_NAME - Name that'll be displayed in the global server list. (String)
# SERVER_PORT - UDP port your server listens on.  You'll need to open that port as well as one above it.  So, for PORT 2456, you'll need to allow UDP ports 2456-2457. (Int)
# WORLD - The world that'll be loaded / created on server startup. (String)

# Optional
# PASSWORD - The password to get into the server, must be 5 chars long. (String)
# SAVEDIR - The directory the server will save files to / read additional config from. (String/Path)
# PUBLIC - Whether to add the server to the global server list (Boolean: 1 or 0)

SERVER_NAME=${SERVER_NAME:="My Server"}
SERVER_PORT=${SERVER_PORT:=2456}
WORLD=${WORLD:="Dedicated"}
PASSWORD=${PASSWORD:="Secret"}
SAVEDIR=${SAVEDIR:="~/.config/unity3d/IronGate/Valheim"}
PUBLIC=${PUBLIC:=1}

if [ -v CONFIGMAP ]
  then
  ln -sf /etc/valheim/adminlist.txt ${SAVEDIR}/adminlist.txt
  ln -sf /etc/valheim/bannedlist.txt ${SAVEDIR}/bannedlist.txt
  ln -sf /etc/valheim/permittedlist.txt ${SAVEDIR}/permittedlist.txt 
fi

/opt/server/valheim_server.x86_64 -name ${SERVER_NAME} -port ${SERVER_PORT} -world ${WORLD} -password ${PASSWORD} -savedir ${SAVEDIR} -public ${PUBLIC}

export LD_LIBRARY_PATH=$templdpath

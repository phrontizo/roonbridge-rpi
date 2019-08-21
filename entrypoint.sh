#!/bin/bash

if [ ! -f ./RoonBridge/Bridge/RoonBridge ]; then
	wget ${ROON_BRIDGE_URL}
	tar -xjf ${ROON_BRIDGE_FILENAME}
	rm ${ROON_BRIDGE_FILENAME}
fi

exec ./RoonBridge/Bridge/RoonBridge

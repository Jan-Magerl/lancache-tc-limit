#!/bin/bash
# Full path to tc binary

i_eth=eth0
i_ibf=ifb211

# Define the upload and download speed limit, follow units can be
# passed as a parameter:
# kbps: Kilobytes per second
# mbps: Megabytes per second
# kbit: kilobits per second
# mbit: megabits per second
# bps: Bytes per second
download_limit=70mbit

function start_tc {
stop_tc
ip link add $i_ibf type ifb
ip link set dev $i_ibf up
tc qdisc add dev $i_eth ingress
tc filter add dev $i_eth parent ffff: protocol ip u32 match u32 0 0 flowid 1a64: action mirred egress redirect dev $i_ibf
tc qdisc add dev $i_ibf root handle 1a64: htb default 1
tc class add dev $i_ibf parent 1a64: classid 1a64:1 htb rate 32000000.0kbit
tc class add dev $i_ibf parent 1a64: classid 1a64:81 htb rate $download_limit ceil $download_limit burst 1250.0KB cburst 1250.0KB
tc qdisc add dev $i_ibf parent 1a64:81 handle 2fbe: netem
tc filter add dev $i_ibf protocol ip parent 1a64: prio 5 u32 match ip dst 0.0.0.0/0 match ip src 0.0.0.0/0 flowid 1a64:81

}

#
# Removes the network speed limiting and restores the default TC configuration
#
function stop_tc {

#tc qdisc del dev $i_eth root
tc qdisc del dev $i_eth ingress
tc qdisc del dev $i_ibf root
ip link set dev $i_ibf down
ip link delete $i_ibf type ifb

}

function show_status {

        tc -s qdisc ls dev $i_ibf
        tc class show dev $i_ibf
        tc filter show dev $i_ibf
        tc qdisc show dev $i_ibf
        tc -s qdisc ls dev $i_eth
        tc class show dev $i_eth
        tc filter show dev $i_eth
        tc qdisc show dev $i_eth
}
#
# Display help
#
function display_help {
        echo "Usage: tc [OPTION]"
        echo -e "\tstart - Apply the tc limit"
        echo -e "\tstop - Remove the tc limit"
        echo -e "\tstatus - Show status"
}

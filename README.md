# lancache-tc-limit
script for set a download rate limit in lancache.net

## Install

```
git clone https://github.com/Jan-Magerl/lancache-tc-limit
cd lancache-tc-limit
chmod +x limit.sh
chmod +x tc-limit.sh
```

## Usage

`limit [OPTION] [BANDWIDTH_RATE]`
copys and executes tc-limit.sh on lancache container

e.g: `./limit start 50mbit`

### [OPTION]          
`start [BANDWIDTH_RATE]` sets a limit 
                
`stop` removes the limit
                
`status` shows tc status

### [BANDWIDTH_RATE]
Bandwidths or rates.  These parameters accept a floating
point number, possibly followed by either a unit (both SI
and IEC units supported), or a float followed by a '%'
character to specify the rate as a percentage of the
device's speed (e.g. 5%, 99.5%). Warning: specifying the
rate as a percentage means a fraction of the current speed; if the speed changes, the value will not be
recalculated.
   
| Syntax      | Description |
| ----------- | ----------- |
| bit or a bare number      | Bits per second       |
| kbit   | Kilobits per second        |
| mbit   | Megabits per second| 
| gbit  |  Gigabits per second| 
| tbit   | Terabits per second| 
| bps    | Bytes per second| 
| kbps   | Kilobytes per second| 
| mbps   | Megabytes per second| 
| gbps   | Gigabytes per second| 
| tbps   | Terabytes per second| 

To specify in IEC units, replace the SI prefix (k-, m-,
g-, t-) with IEC prefix (ki-, mi-, gi- and ti-)
respectively.

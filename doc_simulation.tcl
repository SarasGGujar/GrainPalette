This is the heart of the project. It defined the "Stress Test" environment.

```tcl
# Create a simulator object
set ns [new Simulator]

# Define different colors for NAM (Legitimate = Blue, Attack = Red)
$ns color 1 Blue
$ns color 2 Red

# Open the Trace and NAM files
set tracefile [open out.tr w]
$ns trace-all $tracefile
set namfile [open out.nam w]
$ns namtrace-all $namfile

# Define Finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}

# Create 4 Nodes
set n0 [$ns node]; # Attacker
set n1 [$ns node]; # Legitimate User
set n2 [$ns node]; # Router
set n3 [$ns node]; # Destination Server

# Create Links (Limited bandwidth on the bottleneck link n2-n3)
$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 0.5Mb 20ms DropTail; # Bottleneck link

# Legitimate Traffic (UDP)
set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 500
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp1
set null3 [new Agent/Null]
$ns attach-agent $n3 $null3
$ns connect $udp1 $null3
$udp1 set fid_ 1

# DoS Attack Traffic (High Rate UDP Flood)
set udp0 [new Agent/UDP]
$ns attach-agent $n0 $udp0
set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 1000
$cbr0 set interval_ 0.001; # Very high rate to cause stress
$cbr0 attach-agent $udp0
$ns connect $udp0 $null3
$udp0 set fid_ 2

# Schedule Events
$ns at 0.5 "$cbr1 start"
$ns at 1.5 "$cbr0 start"; # Attack begins
$ns at 4.0 "$cbr0 stop"
$ns at 4.5 "$cbr1 stop"
$ns at 5.0 "finish"

$ns run
BEGIN {
    recvdSize = 0
    startTime = 0.5
    stopTime = 4.5
}
{
    event = $1
    time = $2
    size = $6
    flow_id = $8

    # Calculate throughput for the legitimate flow (fid 1)
    if (event == "r" && flow_id == 1) {
        recvdSize += size
    }
}
END {
    printf("Average Throughput: %.2f Kbps\n", (recvdSize * 8) / ((stopTime - startTime) * 1000))
}

# Network Stress Test & DoS Attack Simulation (NS2)

This repository contains a Network Simulator 2 (NS2) project designed to simulate a Network Stress Test and a Denial of Service (DoS) attack. The project uses **NAM (Network Animator)** for visualization and **AWK** for performance analysis.

## Project Overview
The simulation creates a topology where a legitimate node and an attacker node both send traffic to a single destination. By increasing the packet rate from the attacker, we observe:
- Link congestion.
- Packet drops at the router.
- Degradation of throughput for the legitimate user.

## Files included
- `dos_simulation.tcl`: The main TCL script defining the network topology and traffic agents.
- `analysis.awk`: A script to parse the `.tr` (trace) file and calculate throughput.
- `project_report.pdf`: (Optional) Final documentation.

## How to Run
1. **Prerequisites**: Ensure you have `ns2` and `nam` installed on your Linux system.
   ```bash
   sudo apt-get install ns2 nam

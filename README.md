# AXI4-Lite UVM Verification Environment

A complete UVM-based verification testbench for an AXI4-Lite slave design.

## Repository Structure

```
├── docs/                    # Documentation and design specifications
├── src/
│   ├── design/              # RTL design files
│   │   ├── design.sv        # AXI4-Lite slave DUT
│   │   ├── interface.sv     # AXI interface definition
│   │   └── defines.svh      # Macro definitions
│   └── test_bench/          # UVM testbench components
│       ├── transaction.sv   # AXI transaction item
│       ├── driver.sv        # AXI driver (write & read channels)
│       ├── input_monitor.sv # Input monitor
│       ├── output_monitor.sv# Output monitor
│       ├── sequence.sv      # Test sequences
│       ├── sequencer.sv     # Sequencer
│       ├── virtual_sequence.sv # Virtual sequence
│       ├── virtual_seqr.sv  # Virtual sequencer
│       ├── active_agent.sv  # Active agent
│       ├── passive_agent.sv # Passive agent
│       ├── environment.sv   # UVM environment
│       ├── scoreboard.sv    # Scoreboard
│       ├── subscriber.sv    # Coverage subscriber
│       ├── test.sv          # Test class
│       ├── testbench.sv     # Top-level testbench
│       ├── package.sv       # Package includes
│       └── run.sh           # Simulation run script
└── README.md
```

## Running the Simulation

```bash
cd src/test_bench
bash run.sh
```

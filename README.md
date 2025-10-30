# verilog-buzzer-lick
A Verilog implementation of the iconic jazz phrase “The Lick” on a Basys 2 FPGA using a piezo buzzer.  
Demonstrates finite-state logic, clock division, and hardware-based audio generation.

---

## Overview
- Written in Verilog for a 50 MHz Spartan Basys 2 FPGA board  
- Uses a function-based frequency calculator and a state machine to step through notes  
- Output: piezo buzzer on a GPIO pin  
- Input: toggle switch to start/stop playback

---

## Key Concepts
- Finite-State Machine (FSM) for sequencing notes  
- Clock divider to convert 50 MHz clock to audible frequencies  
- Square-wave generation for tone output
  
---

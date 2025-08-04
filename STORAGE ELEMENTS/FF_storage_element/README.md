# Flip-Flop Based Storage Unit – RTL Reference for ASIC Memory

## Overview

In ASIC design, physical memory blocks like SRAM or ROM are **not explicitly written in RTL**. These are inserted later using **memory macros** provided by foundries or standard cell libraries. They are optimized for area, speed, and power. During the **simulation and early RTL synthesis** phases, we use **flip-flop-based models** to mimic memory behavior. This module provides a **fully synthesizable and parameterizable** memory using flip-flops to emulate real memory.

## Purpose

- Simulates memory behavior during early RTL design.
- Useful for **functional verification** and **synthesis**.
- **Replaced by foundry memory macros** during physical design flow.

## Storage Element – Block Diagram

<img width="819" height="471" alt="Storage_Element drawio" src="https://github.com/user-attachments/assets/9934ac8c-7a78-4a86-8c0a-1aff8738f14b" />


## Module Features

- Fully **parameterizable** word width and depth.
- Synchronous **write** using flip-flops.
- Combinational **read** (one-cycle latency).
- Uses `generate` block to synthesize individual flip-flop elements.
- Easy to integrate into testbenches and simulation environments.


## Parameters

| Parameter | Description                    | Default |
|----------:|--------------------------------|:--------|
| `WIDTH`   | Bit width of each memory word  | 1024    |
| `DEPTH`   | Number of memory locations     | 512     |

## Ports

| Port Name   | Direction | Width                    | Description                        |
|-------------|-----------|--------------------------|------------------------------------|
| `clk`       | input     | 1                        | Clock signal                       |
| `rst`       | input     | 1                        | Asynchronous active-low reset      |
| `read_en`   | input     | 1                        | Read enable                        |
| `write_en`  | input     | 1                        | Write enable                       |
| `address`   | input     | `log2(DEPTH)`            | Address for read/write             |
| `write_data`| input     | `WIDTH`                  | Data to write                      |
| `read_data` | output    | `WIDTH`                  | Data read from memory              |

## Simulation Example

### ModelSim Test Case

### Simulation Behavior:
- **Step 1:** Write operation
  - `write_data = 1`
  - `write_en = 1`
  - `address = 0`
- **Step 2:** Read operation
  - `write_en = 0`
  - `read_en = 1`
  - `address = 0`
- **Result:** `read_data = 1` is read correctly.

### Waveform:
<img width="1358" height="515" alt="FF_storage_element_waveform" src="https://github.com/user-attachments/assets/a83377a9-c454-4c16-92db-0f9a77f6379d" />


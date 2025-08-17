# 4-Stage Arithmetic Pipeline 

This project demonstrates a **4-stage pipeline** implemented in SystemVerilog. The design accepts three inputs (`A`, `B`, `C`) and produces an output (`X`) after passing through four pipeline stages to evaluate:
<p align="center">
  <b>X = 5A + 5B - 4C + 3D </b>
</p>

## Hardware level Pipelining Block Diagram 

![Pipelining_example_RTL](https://github.com/user-attachments/assets/963e2db7-380c-4fca-a1e5-6728acc71b55)

## What is a Pipeline?

A pipeline divides a computation into multiple stages, allowing operations to overlap. Each stage holds intermediate results in registers.

* **Without Stall:** Data flows smoothly through the pipeline, new input is accepted every cycle.
* **With Stall:** Data progression is paused for one or more cycles, keeping current values in place.

## Testbench Code Summary
The testbench (`pipeline_tb.sv`) drives clock, reset, and input stimulus. The project is tested **with and without stall** conditions.

* **Clock:** 10 ns time period (`always` block toggles clock every 5 ns).
* **Reset:** Applied for the first cycle, then de-asserted.
* **Inputs Applied:**

  * At cycle 1 → `A=0, B=0, C=0`
  * At cycle 2 → `A=1, B=1, C=1`
  * At cycle 3 → `A=0, B=0, C=0`

## Simulation Results

### Case 1: **Without Stall**

Pipeline stages move data forward every clock cycle.

| Clock Cycle     | Input A | Input B | Input C | Output X                        |
| --------------- | ------- | ------- | ------- | ------------------------------- |
| 1 (after reset) | 0       | 0       | 0       | - (not ready, pipeline filling) |
| 2               | 1       | 1       | 1       | - (still filling)               |
| 3               | 0       | 0       | 0       | - (still filling)               |
| 4               | -       | -       | -       | Output of first input (0,0,0)   |
| 5               | -       | -       | -       | Output of second input (1,1,1)  |
| 6               | -       | -       | -       | Output of third input (0,0,0)   |

## </i>Output Waveform without stall</i>
<img width="1358" height="574" alt="pipeline_without_stall" src="https://github.com/user-attachments/assets/3a59c333-3fc3-4efa-9fae-611afcaa75f5" />

### Case 2: **With Stall**

Here, a stall is inserted (for example at cycle 3). During the stall, new inputs are not accepted, and pipeline registers hold their values.

| Clock Cycle     | Input A | Input B | Input C | Stall                | Output X                        |
| --------------- | ------- | ------- | ------- | -------------------- | ------------------------------- |
| 1 (after reset) | 0       | 0       | 0       | 0                    | - (not ready)                   |
| 2               | 1       | 1       | 1       | 0                    | - (filling)                     |
| 3               | 0       | 0       | 0       | **1 (stall active)** | - (pipeline frozen)             |
| 4               | 0       | 0       | 0       | 0                    | Output of first input (0,0,0)   |
| 5               | -       | -       | -       | 0                    | Output of second input (1,1,1)  |
| 6               | -       | -       | -       | 0                    | Output of stalled input (0,0,0) |

## </i>Output Waveform without stall</i>

<img width="1358" height="574" alt="pipeline_with_stall" src="https://github.com/user-attachments/assets/0219c9f1-3b06-4ac0-91eb-0375af31b94e" />

## Where Pipelines Are Used?

* CPUs and DSPs for instruction execution
* Graphics pipelines (GPUs)
* High-speed data processing in communication systems

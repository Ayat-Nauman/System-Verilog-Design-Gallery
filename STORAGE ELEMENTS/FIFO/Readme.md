# FIFO Design (First Word Fall Through)

## What is FIFO?
A **FIFO (First-In, First-Out)** is a memory structure used in digital systems where the **first data written** into the storage is the **first data read out**.
It works just like a queue in real life – the first person who enters is the first to leave.

## First Word Fall Through (FWFT)
In a normal FIFO, when you write data, it is stored inside but **not immediately available** at the output until you perform a read.
In a **First Word Fall Through (FWFT) FIFO**, the **first written word automatically appears at the output** (`read`) without needing an explicit pop.

* This makes reading faster because the data is already ready.
* It reduces the latency of the first read cycle.

## Block Diagram

*<img width="688" height="687" alt="FIFO drawio" src="https://github.com/user-attachments/assets/3044d45a-3008-4bd0-9dc9-92a4251bcc44" />*

## Testbench Explanation
We are using **SystemVerilog** for design and simulation on **ModelSim**.
The testbench applies different scenarios to verify FIFO operation.

### Main Points in Testbench:

1. **Reset (`rstn`)**
   * At the start, reset is applied.
   * This clears pointers (`wptr`, `rptr`) and empties the FIFO.

2. **Write Operation (`push`)**
   * When `push=1`, data on `write` is stored at the location pointed by `wptr`.
   * `wptr` increments automatically.
   * If FIFO is full, further writes are ignored (`full=1`).

3. **Read Operation (`pop`)**
   * When `pop=1`, the read pointer (`rptr`) increments.
   * Data at the current `rptr` location is available at output (`read`).
   * If FIFO is empty, no valid data is read (`empty=1`).

4. **First Word Fall Through Behavior**
   * After the first write, the data immediately shows up at `read`.
   * This confirms FWFT functionality.

## Output Waveform

 *<img width="1358" height="574" alt="FALSE_OUTPUT_WAVEFORM" src="https://github.com/user-attachments/assets/36b44bfb-0ac1-4043-a794-34d66723aa37" />*

### Expected Results:

* After reset → FIFO is empty (`empty=1`, `full=0`).
* On first write → `read` shows the same word without a pop (FWFT behavior).
* Continuous writes → Data fills FIFO until `full=1`.
* Reads → Data comes out in the same order it was written.
* After reading all data → `empty=1` again.

## Where is FWFT FIFO Used?

FWFT FIFOs are widely used in **high-speed and streaming data systems**, where reducing latency is critical.
Some examples include:

* **Networking:** Packet buffers in routers/switches.
* **Video/Audio Processing:** Stream data needs immediate availability to avoid delays.
* **Processor Pipelines:** Instruction/data prefetch buffers.
* **DMA (Direct Memory Access) Controllers:** Immediate data transfer without waiting for a read trigger.
* **High-speed Serial Interfaces (e.g., PCIe, Ethernet):** For handling continuous data flow.

## Tools Used

* **Language:** SystemVerilog
* **Simulator:** ModelSim

This README explains FIFO basics, FWFT concept, use-cases, testbench flow, and expected results.

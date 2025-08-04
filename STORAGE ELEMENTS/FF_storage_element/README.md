# 📘 Flip-Flop Based Storage Unit – RTL Reference for ASIC Memory

## 🔍 Overview

In ASIC design, **physical memory blocks** like SRAM or ROM are not coded in RTL. These are provided by the foundry as IP macros optimized for power, area, and speed.

For **simulation and early synthesis**, a flip-flop-based storage unit is used to **mimic memory behavior**. This module is:

- Fully synthesizable
- Technology-independent
- Intended only for simulation, testbenches, or pre-layout synthesis

---

## 🧠 Purpose

- Simulates memory behavior using flip-flops.
- Replaced by actual memory macros during physical design.
- Helps test and verify designs without needing real memory IPs.

---

## 📷 Block Diagram


```markdown


# Accumulator with AXI Stream and Output Sum on 7-Segment Display

This project implements a digital system that reads a stream of numbers via an AXI Stream interface, calculates their sum, and displays the result on a pair of 7-segment displays.

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [System Overview](#system-overview)
- [AXI Stream Interface](#axi-stream-interface)
- [Design Details](#design-details)
- [Testbench](#testbench)


## Introduction

This project is part of an assignment for a digital system design course. The task is to sum a stream of numbers, each of width W, and display the sum on two 7-segment displays using a custom logic design.

## Features

- **AXI Stream Input**: Reads a stream of numbers.
- **Sum Calculation**: Accumulates the sum of the input numbers.
- **7-Segment Display Output**: Converts the sum to a format suitable for dual 7-segment displays.
- **Testbench**: Includes a comprehensive testbench with randomized inputs, assertions, and reset handling.

## System Overview

The system consists of the following main components:
1. **AXI Stream Interface**: Handles the input stream of numbers.
2. **Summation Logic**: Accumulates the sum of the input numbers.
3. **7-Segment Converter**: Converts the sum into a format suitable for dual 7-segment displays.

![System Diagram](https://github.com/PrabathBK/Accumulator-with-AXIS/blob/main/System_Diagram.png?raw=true)

## AXI Stream Interface

### Input (AXI Stream)
- **s_valid**: Signal indicating if the input data is valid.
- **m_ready**: Signal indicating if the module is ready to receive data.
- **s_data [W-1:0]**: Input data of width W.

### Output (AXI Stream)
- **m_valid**: Signal indicating if the output data is valid.
- **s_ready**: Signal indicating if the module is ready to send data.
- **m_data [1:0][6:0]**: Output data for the 7-segment displays.

## Design Details

### Summation Logic
- **Counter**: A counter keeps track of the number of inputs processed.
- **Enable Signal**: The sum register and counter are enabled based on the condition `s_valid && s_ready`.

### 7-Segment Converter

- **Conversion Logic**: Custom combinational logic is used to map the sum to the 7-segment display output.
- **Ones and Tens Place**: The sum is split into ones and tens place using the modulo and division operations.

### Output Signals

- **m_data[0][6:0]**: Represents the ones place of the sum on the 7-segment display.
- **m_data[1][6:0]**: Represents the tens place of the sum on the 7-segment display.

## Testbench

- **Randomized Inputs**: Uses randomized input values to test the design.
- **Assertions**: Includes assertions to validate the correctness of the sum.
- **Waveform Analysis**: Waveform screenshots are included to demonstrate the functionality.

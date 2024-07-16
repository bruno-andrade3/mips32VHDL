# MIPS32 Processor in VHDL

This project aims to implement a MIPS32 processor in VHDL. 

This README outlines the key components required for the development of the processor, including control signals and datapath components.

## Project Structure

The project is structured into several key modules, each responsible for different aspects of the MIPS32 processor. The main components are:

1. **Control Unit**
2. **Datapath Components**
3. **External Memory**

## Control Signals

The control unit generates the necessary control signals to manage the operation of the processor. The following control signals are required:

- **RegWrite**: Enables writing to the register file.
- **RegDst**: Determines the destination register for the result.
- **ALUSrc**: Selects the ALU input source.
- **Branch**: Indicates a branch instruction.
- **MemWrite**: Enables writing to memory.
- **MemtoReg**: Selects the data source for the register.
- **ALUOp**: Specifies the operation to be performed by the ALU.
- **Jump**: Indicates a jump instruction.

## Datapath Components

The datapath components are the building blocks of the processor, responsible for executing instructions. The following components need to be developed:

1. **Program Counter (PC)**
   - Keeps track of the address of the next instruction.

2. **Instruction Memory**
   - Stores the instructions to be executed.

3. **Register File**
   - Contains the set of registers used by the processor.

4. **ALU (Arithmetic Logic Unit)**
   - Performs arithmetic and logical operations.

5. **Sign Extend**
   - Extends the immediate field of the instruction to 32 bits.

6. **MUX (Multiplexers)**
   - Used to select between different inputs.

7. **Data Memory**
   - Stores data that can be read from or written to by the processor.

8. **Adder**
   - Calculates PCPlus4
   - Calculates the target address for branch instructions.

9. **Shift Left 2**
    - Shifts the branch address left by 2 bits.
    - Used in the jump instruction

## Development Process

1. **Design the Datapath**:
   - Draw the datapath for the MIPS32 processor, identifying all necessary components and connections.
    ![MIPS32 datapath](/img/mips_datapath.PNG)

2. **Implement Individual Components**:
   - Develop VHDL code for each datapath component listed above.

3. **Implement the Control Unit**:
   - Develop VHDL code for the control unit to generate the appropriate control signals.
    ![Control](img\control.PNG)
4. **Implement the Memory**:
   - Develop VHDL code for the control unit to generate the appropriate control signals.


5. **Integrate Datapath and Control Unit**:
   - Combine the datapath components and control unit into a single entity.

6. **Testing and Verification**:
   - Create testbenches to verify the functionality of individual components and the overall processor.
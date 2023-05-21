# Pipeline
This project's main goal was to develop a fully functioning pipeline with data forwarding and branch "not-taken" prediction. The pipeline can handle different assembly programs preventing unnecessary stalling and handling branches.  

# Testing
Load data in the following ROMs: 
1. IR controller (IrController circuit):
• Copy hex values from the IR controller table and paste it into the IR MAIN ROM.
• Copy hex values from the SEQ table and paste it into the SEQ ROM.
2. EX controller (ExController circuit):
• Copy hex values from the EX controller table and paste it into the EX MAIN ROM.
• Copy hex values from the SEQ table and paste it into the SEQ ROM.
• Copy hex values from the WRITE BACK table and paste it into the WRITE BACK ROM.
3. MEM controller (MemController circuit):
• Copy hex values from the MEM controller table and paste it into the MEM MAIN ROM.
• Copy hex values from the SEQ table and paste it into the SEQ ROM.
• Copy hex values from the WRITE BACK table and paste it into the WRITE BACK ROM.
4. WB controller (WbController circuit):
• Copy hex values from the WB controller table and paste it into the WB MAIN ROM.
• Copy hex values from the SEQ table and paste it into the SEQ ROM.
• Copy hex values from the WRITE BACK table and paste it into the WRITE BACK ROM.
5. I-MEM and D-MEM:
• Copy hex values from pow.hex to I-MEM and D-MEM.

# Areas for improvement
1. Increasing number of stages in the pipeline.
2. Implement out-of-order execution of instruction mechanism. 
3. Implement a better Branch prediction strategy, for example Branch Target Buffer. 

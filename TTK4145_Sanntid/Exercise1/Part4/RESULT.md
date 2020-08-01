When you run the different programs several times, the magic number i fluctuates between -1 000 000 and 1 000 000.

This is due to concurrency. Due to incrementing and decrementing being non-atomic processes, it is random which of the two functions will overwrite the variable. Sometimes the incrementing-function will "win" the control over the variable and overwrite, and sometimes the decrementing-function will overwrite. This results in the value of i being random.



# Mutex and Channel basics

 ### What is an atomic operation?
 > An atomic operation is an operation that is seen by other threads as happening instantaneously. In an atomic operation, the processor can simultaneously read a location and write to it in the same bus operation. This prevents any other processor or I/O device from writing or reading memory until the operation is complete.

 ### What is a semaphore?
 > A semaphore is a variable or abstract data type used to control access to a common resource by multiple processes in a concurrent system.

 ### What is a mutex?
 > Mutex is short for mutual exclusion. The mutex works as a gate keeper to a section of code allowing only one thread in and blocking access to all others. This ensures that the code being controlled will only be hit by a single thread at a time. In this way, shared variables can be protected from being modified by several threads simultaneously. 
    
 ### What is the difference between a mutex and a binary semaphore?
 > Mutex is a locking mechanism used to synchronize access to a resource. Only one task can acquire the mutex. This implies that there is ownership associated with the mutex, and only the ownercan release the lock (mutex).

 > On the other hand, a binary semaphore is a signalling mechansim. For example "I am done you can carry on". There is no "locking" of resources included. 

 ### What is a critical section?
 > A critical section is the part of a prgram that accesses shared resources. 


 ### What is the difference between race conditions and data races?
 > A data race occurs when two instructions from different threads access the same memory location, at least one of these accesses is a write and there is no synchronization controlling the order between these accesses. It is then "a race" between these two accesses. The data lying at the memory location, or being read by the one instruction, after the two instructions are completed depends on the order of the instructions being completed.

 > A race condition, on the other hand, is a semantic error. A race condition flaw occurs when the timing or ordering of events affects a program's correctness. 
 

 ### List some advantages of using message passing over lock-based synchronization primitives.
 > Do not have to worry about details of protections.

 > Useful for exchanging smaller amounts of data, because no conflicts need to be avoided.

 > Easier to implement.

List some advantages of using lock-based synchronization primitives over message passing.
 > Allows maximum speed and convenience of communication. The communication can be done at memory speeds within a computer.

 >Usually faster. Do not require to use extensive amounts of system calls.


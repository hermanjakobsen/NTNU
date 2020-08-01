# Reasons for concurrency and parallelism


To complete this exercise you will have to use git. Create one or several commits that adds answers to the following questions and push it to your groups repository to complete the task.

When answering the questions, remember to use all the resources at your disposal. Asking the internet isn't a form of "cheating", it's a way of learning.

 ### What is concurrency? What is parallelism? What's the difference?
 > Concurrency means that multiple computations are virtually happening at the same time. The CPU switches between doing parts of the different tasks. An example is multiple applications running on one computer. One can for instance load multiple documents simultaneously in the tabs of a browser while still being able to open menus and perform other actions. Concurrency can be implemented on a single processing unit.

 > Parallelism is closely related to concurrency. However, parallelism makes use of multiple processing units. A computational task is typically broken down into several very similar subtasks that can be processed independently and whose results are combined afterwards, upon completion. An example is graphic computations on a GPU.

 > The difference is:
Concurrency is when two tasks can start, run and complete in overlapping time periods. Parallelism is when tasks literally run at the same time. Concurrency is about dealing with lots of things at once, while parallelism is about doing lots of things at once.
 
 
 ### Why have machines become increasingly multicore in the past decade?
 > Multicore machines are more effective than a single core machine. At the same clock frequency, the multicore processors will process more data than the single core. Multicore machines also allow parallelism which make programs faster by performing several computations at the same time. Further, the multicores often operate at a lower frequency than the single core, which affects the power usage.

 > Summarized: 
Multicore processors deliver high performance and handle complex tasks at a comparatively lower energy or lower power compared to a single core. 

 ### What kinds of problems motivates the need for concurrent execution?
 (Or phrased differently: What problems do concurrency help in solving?)
 > Problems that are separate and independent can be executed simultaneously. 
 
 ### Does creating concurrent programs make the programmer's life easier? Harder? Maybe both?
 (Come back to this after you have worked on part 4 of this exercise)
 > I think concurrent programs make the programmer's life both harder and easier. Concurrent programming opens up more possibilites and will help solve some classes of problems. However, it is demanding to manage the different variables shared among the threads.
 
 ### What are the differences between processes, threads, green threads, and coroutines?
 > A process is an executing program. One or more threads run in the context of the process.

 > A thread is the basic unit to which the operating system allocates processor time. A thread can execute any part of the process code.

 > Green threads are "user-level-threads". They are scheduled by a user-level process, and not by the kernel. Green threads can be used to simulate multi-threading on platforms that do not provide that capability. 

 > A coroutine is similar to a thread where it is a line of execution with its own stack, own local variables and its own instruction pointer. However, a coroutine shares global variables and mostly anything else with other coroutines. While several threads can be run in parallel, coroutines are only ran one at the time. Coroutine can be defined as "collaborative threads".
 
 ### Which one of these do `pthread_create()` (C/POSIX), `threading.Thread()` (Python), `go` (Go) create?
 > `pthread_create()` - starts a new thread

 > `threading.Thread()` - creates a thread object

 > `go` - starts a goroutine. A goroutine is a lightweight thread of execution.
 
 ### How does pythons Global Interpreter Lock (GIL) influence the way a python Thread behaves?
 > GIL is a mutex that protects access to Python objects. It prevents multiple threads from executing Python bytecodes at once. This lock is necessary because CPython's memory management is not thread-safe.
 
 ### With this in mind: What is the workaround for the GIL (Hint: it's another module)?
 > Multiprocess module. The module utilizes subprocesses instead of threads.
 
 ### What does `func GOMAXPROCS(n int) int` change? 
 > The GOMAXPROCS variable limits the number of operating system threads that can execute user-level Go code simultaneously.

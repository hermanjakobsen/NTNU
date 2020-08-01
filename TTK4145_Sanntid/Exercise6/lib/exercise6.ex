defmodule EX6 do

  def main do
    # Initializing by spawning two processes
    backupPID = spawn(fn -> backup(1) end)
    spawn(fn -> primary(1, backupPID) end) # Primary
  end  


  def primary(num, pid) do
    if num == 3 or num == 6 do
      Process.exit(self(), :normal) # Simulating a crash
    end
    IO.puts("\nPrimary: #{inspect(self())}, printing number #{num}")
    send(pid, :alive) # Send "heartbeat" message
    :timer.sleep(3000)
    primary(num+1, pid)
  end

  def backup(num) do
    receive do
      :alive ->
        IO.puts("Backup: #{inspect(self())}")
        backup(num+1)
    
    after
      5_000 ->
        IO.puts("Primary died :(")
        IO.puts("Backup taking over! Primary died at number #{num}")
        backupPID = spawn(fn -> backup(num+1) end)
        primary(num+1, backupPID)
    end
  end
 
end

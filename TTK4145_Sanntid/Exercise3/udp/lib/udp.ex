defmodule Udp do

  @network %{ip: {10, 100, 23, 242}, port: 20013}
	@local %{ip: {127, 0, 0, 1}, port: 8791} # Not needed

	def main() do
		{:ok, socket} = :gen_udp.open(@network.port)

		spawn(Udp, :transmit, [socket])
		recv = spawn(Udp, :receive, []) # Spawns a process and assigns pid 
		:gen_udp.controlling_process(socket, recv) # Assigns a process to receive messages from socket
	end

	def transmit(socket) do
		:ok = :gen_udp.send(socket, @network.ip, @network.port, "Sup?") 
		:timer.sleep(2000)
		transmit(socket) # Recursive call (loop)
	end

	def receive() do
		receive do
			{:udp, _socket, _ip, _inPortNo, packet} -> # Prints packet if meessage satisfies the content form
				Enum.slice(packet, 0..13) |> IO.puts  # Slices the packet (which is an enum) to get rid of unwanted information
		end
		receive() # Recursive call (loop)
	end
end
  
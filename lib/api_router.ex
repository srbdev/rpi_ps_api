defmodule ApiRouter do
  use Plug.Router

  # plug Plug.Logger
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hello, rpi_ps_api!")
  end

  get "/cpu" do
    {str, _} = System.cmd("uptime", [])
    load = str
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      |> Enum.at(3)
      |> String.replace("load average: ", "")
      |> String.to_float
    cpu = round(load * 100) |> Integer.to_string
    send_resp(conn, 200, cpu)
  end

  get "/ram" do
    {str, _} = System.cmd("free", ["-b"])
    [_, mem, _] = str |> String.split("\n", parts: 3)
    <<_::binary-size(4), total::binary-size(15), used::binary-size(12), _::binary>> = mem
    used = used
      |> String.trim
      |> String.to_integer
    total = total
      |> String.trim
      |> String.to_integer
    ram = round(used / total * 100) |> Integer.to_string
    send_resp(conn, 200, ram)
  end

  get "/temp" do
    # temp=52.0'C
    {str, _} = System.cmd("vcgencmd", ["measure_temp"])
    temp = str
      |> String.split("=")
      |> Enum.at(1)
      |> String.trim
      |> String.replace("'C", "")
      |> String.to_float
      |> round
      |> Integer.to_string
    send_resp(conn, 200, temp)
  end
end

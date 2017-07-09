require 'socket'

server = TCPServer.new('192.168.0.100', 8000)

loop do
  socket = server.accept
  request = socket.gets

  puts request

  response = "<div style=\"color: red;\">Hello There!</div>\n"

  socket.print "HTTP/1.1 200 OK\r\n" +
               "Content-Type: text/html\r\n" +
               "Content-Length: #{response.bytesize}\r\n" +
               "Connection: close\r\n" +
               "\r\n" +
               response
  socket.close
end
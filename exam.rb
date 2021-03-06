require 'webrick'
server = WEBrick::HTTPServer.new({
  :DocumentRoot => 'http://localhost:2000/exam',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,
  :Port => '2000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}
server.mount('/', WEBrick::HTTPServlet::ERBHandler, 'exam.html.erb')
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.start
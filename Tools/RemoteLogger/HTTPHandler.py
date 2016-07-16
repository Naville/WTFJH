import sqlite3
import json
from SimpleHTTPServer import SimpleHTTPRequestHandler
class HTTPHandler(SimpleHTTPRequestHandler):
	Connection=None
	def __init__(self,req,client_addr,server):
		SimpleHTTPRequestHandler.__init__(self,req,client_addr,server)
	def do_POST(self):
		SQL = self.headers.getheader('SQL-Command', 0)
		if(self.Connection==None):
			self.Connection=sqlite3.connect(self.headers.getheader('DatabaseName', 0))
		self.Connection.cursor().execute(SQL)
		self.Connection.commit()
    	#return SimpleHTTPRequestHandler.do_POST(self)
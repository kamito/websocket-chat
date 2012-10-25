websocket-chat
==============

Chat with WebSocket on Terminal.

Install
--------------
```
$ git clone git://github.com/kamito/websocket-chat.git
```

Setup
--------------
Rewrite server and client.

server
```ruby
## Settings
#--------------------
# HOST
HOST = "127.0.0.1"
# PORT
PORT = 51234
#--------------------
```

client
```ruby
## Settings
#--------------------
# SERVER (host and port with "ws" protocol)
SERVER = "ws://127.0.0.1:51234"
#--------------------
```

Run server
--------------
```
$ cd /path/to/checkout/directory
$ ./server
```

Running server to daemon with "-D" option.
```
$ cd /path/to/checkout/directory
$ ./server -D
Run server with daemon.
$
```

Shutdown
```
$ ./server-close
Shutdown server. Bye bye.
$
```

Chat client
--------------
```
$ ./client #{Your name}
```

name is \[a-zA-Z0-9\]

example
```
$ cd /path/to/checkout/directory
$ ./client kamito
Connected session.
Loggedin kamito

```

Enter text to blank line and Return.
Send message to Chat server.


Enjoy

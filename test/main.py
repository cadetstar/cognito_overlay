import sys
import os
from werkzeug.middleware.dispatcher import DispatcherMiddleware
from werkzeug.serving import run_simple
from flask import Flask

sys.path.append(os.path.dirname(sys.path[0]))

from src import auth

app = Flask(__name__)

@app.route('/hello')
def hello():
  return 'Hello!'

application = DispatcherMiddleware(app, {
  '/auth': auth('myconreg.xyz')
})

run_simple('localhost', 5000, application, use_reloader=True)

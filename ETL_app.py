import datetime as dt
import numpy as np
import pandas as pd
from config import user_nm, user_pw, user_port


import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, render_template, redirect

#################################################
# Flask Setup
#################################################
app = Flask(__name__)

#################################################
# Flask Routes
#################################################

@app.route('/')
def home():
    return render_template("index.html")


@app.route('/happiness')
def happiness():
    connection_string = f"{user_nm}:{user_pw}@localhost:{user_port}/world_db"
    engine = create_engine(f'postgresql://{connection_string}')
    connection = engine.connect()
    happiness_df = pd.read_sql("SELECT * FROM happiness", connection)
    connection.close()
    redirect("/data")

@app.route('/data')
def data():
    results = happiness_df
    return render_template("data.html", info = results)

if __name__ == "__main__":
    app.run(debug = True)

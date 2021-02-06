import pandas as pd
from config import user_nm, user_pw, user_port

from sqlalchemy import create_engine
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


@app.route("/happiness", endpoint = "HappyEnd")
def happiness():
    print("Server received request for POSTGRES connection...")
    connection_string = f"{user_nm}:{user_pw}@localhost:{user_port}/world_db"
    engine = create_engine(f'postgresql://{connection_string}')
    connection = engine.connect()
    df = pd.read_sql("SELECT * FROM happiness", connection)
    connection.close()
    html_table = df.to_html(index=False, header=True, border=1, justify = 'left',classes="bg-light table table-striped table-bordered")
    results = html_table
    return render_template("data.html", info = results)


@app.route("/alcohol", endpoint = "AlcoEnd")
def happiness():
    print("Server received request for POSTGRES connection...")
    connection_string = f"{user_nm}:{user_pw}@localhost:{user_port}/world_db"
    engine = create_engine(f'postgresql://{connection_string}')
    connection = engine.connect()
    df = pd.read_sql("SELECT * FROM alcohol_consumption", connection)
    connection.close()
    html_table = df.to_html(index=False, header=True, border=1, justify = 'left',classes="bg-light table table-striped table-bordered")
    results = html_table
    return render_template("data.html", info = results)


if __name__ == "__main__":
    app.run(debug = True)

import pandas as pd
from config import user_nm, user_pw, user_port

from sqlalchemy import create_engine
from flask import Flask, render_template, redirect,request

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


@app.route("/happiness")
def happiness():
    print("Server received request for POSTGRES connection for happiness query...")
    connection_string = f"{user_nm}:{user_pw}@localhost:{user_port}/world_db"
    engine = create_engine(f'postgresql://{connection_string}')
    connection = engine.connect()
    query = "SELECT country, happiness_rank, happiness_score, gdp_per_capita, family, life_expectancy, freedom, trust_government, generosity, dystopia_residual FROM happiness WHERE year = 2017 ORDER BY happiness_rank"
    df = pd.read_sql(query, connection)
    connection.close()
    html_table = df.to_html(index=False, header=True, border=1, justify = 'left',classes="bg-light table table-striped table-bordered")
    results = html_table
    return render_template("data.html", info = results, query = query)

@app.route("/alcohol")
def alcohol():
    print("Server received request for POSTGRES connection for alcohol query...")
    connection_string = f"{user_nm}:{user_pw}@localhost:{user_port}/world_db"
    engine = create_engine(f'postgresql://{connection_string}')
    connection = engine.connect()
    query = "SELECT T1.country, T2.ranking, T1.gender, T1.per_capita_consumption\
    FROM (SELECT country, gender, AVG(per_capita_consumption) AS per_capita_consumption FROM alcohol_consumption GROUP BY country, gender ORDER BY 3 DESC, 1) AS T1\
    INNER JOIN (SELECT country, per_capita_consumption, ROW_NUMBER () OVER (ORDER BY per_capita_consumption DESC) AS ranking \
    FROM (SELECT country, AVG(per_capita_consumption) AS per_capita_consumption FROM alcohol_consumption GROUP BY country ORDER BY 2 DESC) AS T3) AS T2\
    ON T1.country = T2.country ORDER BY 2"
    df = pd.read_sql(query, connection)
    connection.close()
    html_table = df.to_html(index=False, header=True, border=1, justify = 'left',classes="bg-light table table-striped table-bordered")
    results = html_table
    return render_template("data.html", info = results, query = query)

@app.route("/anti_dep")
def anti_dep():
    print("Server received request for POSTGRES connection for happiness query...")
    connection_string = f"{user_nm}:{user_pw}@localhost:{user_port}/world_db"
    engine = create_engine(f'postgresql://{connection_string}')
    connection = engine.connect()
    query = "SELECT country,daily_dosage_per_1k, year, notes FROM antidepressant_consumption ORDER BY daily_dosage_per_1k DESC"
    df = pd.read_sql(query, connection)
    connection.close()
    html_table = df.to_html(index=False, header=True, border=1, justify = 'left',classes="bg-light table table-striped table-bordered")
    results = html_table
    return render_template("data.html", info = results, query = query)

@app.route("/world_avg_happiness")
def avg_happiness():
    print("Server received request for POSTGRES connection for average happiness query...")
    connection_string = f"{user_nm}:{user_pw}@localhost:{user_port}/world_db"
    engine = create_engine(f'postgresql://{connection_string}')
    connection = engine.connect()
    query = "SELECT AVG(happiness_score) as average_happiness From happiness"
    df = pd.read_sql(query, connection)
    connection.close()
    html_table = df.to_html(index=False, header=True, border=1, justify = 'left',classes="bg-light table table-striped table-bordered")
    results = html_table
    return render_template("data.html", info = results, query = query)

@app.route("/happiness_map")
def happiness_map():
    return render_template("happiness_world.html")

@app.route("/alcohol_map")
def alcohol_map():
    return render_template("alc_world.html")

@app.route("/anti_dep_map")
def anti_dep_map():
    return render_template("anti_dep_world.html")

@app.route("/custom")
def custom():
    return render_template("custom.html")

@app.route("/custom_query", methods=['GET', 'POST'])
def custom_query():
    print("Server received request for POSTGRES connection for custom query...")
        
    table = request.form['table']
    if request.form['year'] != "":
        year= int(request.form['year'])
    else:
        year = ""
    com_op= request.form['com_op']
    country= request.form['country']

    
    connection_string = f"{user_nm}:{user_pw}@localhost:{user_port}/world_db"
    engine = create_engine(f'postgresql://{connection_string}')
    
    connection = engine.connect()
       
    if (table != "") and  (year != "") and (com_op != "") and (country != ""):
        query = f"SELECT * FROM {table} WHERE year {com_op} {year} AND country = {country}"
    elif (table != "") and  (year != "") and (country != ""):
        query = f"SELECT * FROM {table} WHERE year = {year} AND country = {country}"
    elif (table != "") and  (year != "") and (com_op != ""):
        query = f"SELECT * FROM {table} WHERE year {com_op} {year}"
    elif (table != "") and (country != ""):
        query = f"SELECT * FROM {table} WHERE country = {country}"
    elif (table != "") and  (year != ""):
        query = f"SELECT * FROM {table} WHERE year = {year}"
    else:
        query = f"SELECT * FROM {table}"
        

    # query = f"SELECT * FROM {table}"
    df = pd.read_sql(query, connection)
    connection.close()
    html_table = df.to_html(index=False, header=True, border=1, justify = 'left',classes="bg-light table table-striped table-bordered")
    results = html_table
    return render_template("data.html", info = results, query = query)

if __name__ == "__main__":
    app.run(debug = True)

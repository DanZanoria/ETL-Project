DROP TABLE IF EXISTS happiness;
DROP TABLE IF EXISTS alcohol_consumption;
DROP TABLE IF EXISTS antidepressant_consumption;

-- CREATE TABLE FOR WORLD HAPPINESS INDEX DATA
CREATE TABLE happiness(
			id                SERIAL PRIMARY KEY,
			country           VARCHAR,
			happiness_rank    INTEGER,
			happiness_Score   NUMERIC(6,4),
			GDP_per_capita    NUMERIC(6,4),
			family            NUMERIC(6,4),
			life_expectancy   NUMERIC(6,4),
			freedom           NUMERIC(6,4),
			trust_government  NUMERIC(6,4),
			generosity        NUMERIC(6,4),
			dystopia_residual NUMERIC(6,4),
			year              INTEGER

);
--  CREATE TABLE FOR WORLD ALCOHOL CONSUMPTION DATA
CREATE TABLE alcohol_consumption(
			id                SERIAL PRIMARY KEY,
			country                  VARCHAR,
			year                     INTEGER,
			gender                   VARCHAR,
			per_capita_consumption   NUMERIC(6,4)
);
--  CREATE TABLE FOR WORLD ANTIDEPRESSANT CONSUMPTION DATA
CREATE TABLE antidepressant_consumption(
			id               SERIAL PRIMARY KEY,
			country                  VARCHAR,
			daily_dosage_per_1k    	 DOUBLE PRECISION,
			year                     INTEGER,
			notes                    VARCHAR
);

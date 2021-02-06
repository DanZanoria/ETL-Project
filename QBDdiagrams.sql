-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "happiness" (
    "id" Serial   NOT NULL,
    "country" VARCHAR   NOT NULL,
    "happiness_rank" INT   NOT NULL,
    "happines_Score" Numeric   NOT NULL,
    "GDP_per_capita" Numeric   NOT NULL,
    "family" Numeric   NOT NULL,
    "life_expectancy" Numeric   NOT NULL,
    "freedom" Numeric   NOT NULL,
    "genorosity" Numeric   NOT NULL,
    "year" Integer   NOT NULL,
    CONSTRAINT "pk_happiness" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "alcohol_consumption" (
    "id" Serial   NOT NULL,
    "country" Varchar   NOT NULL,
    "year" Integer   NOT NULL,
    "gender" Varchar   NOT NULL,
    "per_capita_consumption" Numeric   NOT NULL,
    CONSTRAINT "pk_alcohol_consumption" PRIMARY KEY (
        "id"
     )
);

CREATE TABLE "antidepressant_consumption" (
    "id" Serial   NOT NULL,
    "country" VarChar   NOT NULL,
    "daily_dosoage_per_1k" Double-Precision   NOT NULL,
    "year" Integer   NOT NULL,
    "notes" VARCHAR   NOT NULL,
    CONSTRAINT "pk_antidepressant_consumption" PRIMARY KEY (
        "id"
     )
);

ALTER TABLE "happiness" ADD CONSTRAINT "fk_happiness_id_year" FOREIGN KEY("id", "year")
REFERENCES "antidepressant_consumption" ("id", "year");

ALTER TABLE "happiness" ADD CONSTRAINT "fk_happiness_country" FOREIGN KEY("country")
REFERENCES "alcohol_consumption" ("country");

ALTER TABLE "alcohol_consumption" ADD CONSTRAINT "fk_alcohol_consumption_id_country" FOREIGN KEY("id", "country")
REFERENCES "antidepressant_consumption" ("id", "country");

ALTER TABLE "antidepressant_consumption" ADD CONSTRAINT "fk_antidepressant_consumption_country" FOREIGN KEY("country")
REFERENCES "happiness" ("country");

ALTER TABLE "antidepressant_consumption" ADD CONSTRAINT "fk_antidepressant_consumption_year" FOREIGN KEY("year")
REFERENCES "alcohol_consumption" ("year");


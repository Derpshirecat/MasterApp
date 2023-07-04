#!/bin/bash

# Set SQLite database path
DB_PATH="jokesDB.db"

# Set CSV file path and table name
CSV_FILE="jokedb.csv"
TABLE_JOKES_NAME="Jokes"
TABLE_RECORD_NAME="Records"

# Create Jokes table
sqlite3 "$DB_PATH" <<EOF
CREATE TABLE IF NOT EXISTS $TABLE_JOKES_NAME (
    idjoke int,
    question TEXT,
    pun TEXT,
    favorite int
);
EOF

# Create records table
sqlite3 "$DB_PATH" <<EOF
CREATE TABLE IF NOT EXISTS $TABLE_RECORD_NAME (
    dateString TEXT,
    idjoke int
);
EOF

# Import CSV data into SQLite table
sqlite3 "$DB_PATH" <<EOF
.mode csv
CREATE TABLE IF NOT EXISTS temp_table AS SELECT * FROM $TABLE_JOKES_NAME WHERE 0;
.separator ';'
.import "$CSV_FILE" temp_table
INSERT INTO $TABLE_JOKES_NAME SELECT * FROM temp_table WHERE NOT EXISTS (SELECT 1 FROM $TABLE_JOKES_NAME WHERE $TABLE_JOKES_NAME.idjoke = temp_table.idjoke);
DROP TABLE IF EXISTS temp_table;
EOF


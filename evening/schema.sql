CREATE TABLE IF NOT EXISTS ListOfQuizSet (
    id INTEGER PRIMARY KEY,
    name TEXT,
    descript TEXT
);

CREATE TABLE IF NOT EXISTS ListOfFlashcard (
    id INTEGER PRIMARY KEY,
    term TEXT,
    def TEXT,
    parent_id INTEGER,
    FOREIGN KEY (parent_id) REFERENCES ListOfQuizSet(id)
);


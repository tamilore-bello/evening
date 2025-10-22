CREATE TABLE IF NOT EXISTS ListOfQuizSet (
    id TEXT PRIMARY KEY,
    name TEXT,
    descript TEXT
);

CREATE TABLE IF NOT EXISTS ListOfFlashcard (
    id TEXT PRIMARY KEY,
    term TEXT,
    def TEXT,
    FOREIGN KEY (parent_id) REFERENCES ListOfQuizSet(id)
);


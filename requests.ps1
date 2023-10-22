$create_poids = "CREATE TABLE [weights](
  [id] INT PRIMARY KEY UNIQUE, 
  [jour] DATE NOT NULL, 
  [poids] DOUBLE NOT NULL, 
  [remarque] TEXT);"
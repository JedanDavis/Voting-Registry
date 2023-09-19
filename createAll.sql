CREATE TABLE IF NOT EXISTS Folk (
     ID VARCHAR(10) PRIMARY KEY,
     first_name VARCHAR(20),
     last_name VARCHAR(20),
     nickname VARCHAR(20),
     pid VARCHAR(10),
     dob DATE
);


CREATE TABLE IF NOT EXISTS Folk_Phone (
	ID VARCHAR(10),
    phonetype VARCHAR(10),
    phone_number INT(15),
    PRIMARY KEY (ID, phonetype, phone_number),
    FOREIGN KEY(ID) REFERENCES Folk(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Folk_Email (
	ID VARCHAR(10),
    email VARCHAR(25),
	PRIMARY KEY (ID, email),
    FOREIGN KEY(ID) REFERENCES Folk(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Election_Staff (
	ID VARCHAR(10),
	Unique_Acronym VARCHAR(15),
	PRIMARY KEY (ID),
    FOREIGN KEY(ID) REFERENCES Folk(ID) ON DELETE CASCADE
);
 


CREATE TABLE IF NOT EXISTS Clerk (
	ID VARCHAR(10),
    Clerk_ID VARCHAR(10),
    Salary NUMERIC(8,2),
	PRIMARY KEY (ID, Clerk_ID),
    FOREIGN KEY(ID) REFERENCES Election_Staff(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS monitors (
	ID VARCHAR(10),
    monitors_ID VARCHAR(10),
    Salary NUMERIC(8,2),
	PRIMARY KEY (ID, monitors_ID),
    FOREIGN KEY(ID) REFERENCES Election_Staff(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Judge (
	ID VARCHAR(10),
    Judge_ID VARCHAR(10),
    Salary NUMERIC(8,2),
	PRIMARY KEY (ID, Judge_ID),
    FOREIGN KEY(ID) REFERENCES Election_Staff(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Administrator (
	ID VARCHAR(10),
    Administrator_ID VARCHAR(10),
    Salary NUMERIC(8,2),
	PRIMARY KEY (ID, Administrator_ID),
    FOREIGN KEY(ID) REFERENCES Election_Staff(ID) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Place (
	pid VARCHAR(10),
    street_num VARCHAR(10),
    street_name VARCHAR(25),
    city VARCHAR(20),
    state VARCHAR(15),
    zipcode INT(5),
    x_coords INT(5),
    y_coords INT(5),
    PRIMARY KEY (pid, street_num, street_name, city, state, zipcode)
);

CREATE TABLE IF NOT EXISTS Ballots(
    Ballot_ID VARCHAR(10) PRIMARY KEY,
    short_name VARCHAR(20) NOT NULL,
    Question VARCHAR(300),
    Ballots_Date DATE NOT NULL,
    start_at DATE,
    end_at DATE
);


CREATE TABLE IF NOT EXISTS Voting_Center (
	Unique_Acronym VARCHAR(15),
	pid VARCHAR(10),
   
    PRIMARY KEY ( Unique_Acronym, pid )
);

CREATE TABLE IF NOT EXISTS VC_Operating_periods  (
    Unique_Acronym VARCHAR(15),
	start_at DATE,
    Open_time TIME,
    close_time TIME,
    end_at DATE,   
    PRIMARY KEY (Unique_Acronym, start_at,Open_time,end_at,close_time),
    FOREIGN KEY(Unique_Acronym) REFERENCES Voting_Center(Unique_Acronym)
);


CREATE TABLE IF NOT EXISTS Cast_Vote (
    Confirmation_Number VARCHAR(10) PRIMARY KEY,
    ID VARCHAR(10),
    Staff_ID VARCHAR(10),
    Ballot_ID VARCHAR(10),
	Answer VARCHAR(7),
    CHECK (Answer IN ('yes', 'no', 'abstain',NULL)),
    Cast_Vote_Date DATE NOT NULL,
    Unique_Acronym VARCHAR(15),
    
    UNIQUE (Ballot_ID, ID),
    FOREIGN KEY(ID) REFERENCES Folk(ID) ON DELETE CASCADE,
    FOREIGN KEY(Ballot_ID) REFERENCES Ballots(Ballot_ID),
	FOREIGN KEY(Staff_ID) REFERENCES Election_Staff(ID) ON DELETE CASCADE,
    FOREIGN KEY(Unique_Acronym) REFERENCES Voting_Center(Unique_Acronym)

);

CREATE TABLE IF NOT EXISTS Voting_Registry (
	ID VARCHAR(10),
    Unique_Acronym VARCHAR(15),
	Ballot_ID VARCHAR(10),
    Voting_Date Date,
	PRIMARY KEY ( ID, Unique_Acronym, Ballot_ID, Voting_Date),
	FOREIGN KEY(ID) REFERENCES Folk(ID) ON DELETE CASCADE,
    FOREIGN KEY(Unique_Acronym) REFERENCES Voting_Center(Unique_Acronym),
	FOREIGN KEY(Ballot_ID) REFERENCES Ballots(Ballot_ID)
);



CREATE TABLE IF NOT EXISTS Scheduled (
    Unique_Acronym VARCHAR(15),
    ID VARCHAR(10),
	start_date_time DATE,
    end_date_time DATE,
    PRIMARY KEY (Unique_Acronym, ID),
    FOREIGN KEY(Unique_Acronym) REFERENCES Voting_Center(Unique_Acronym),
    FOREIGN KEY(ID) REFERENCES Election_Staff(ID) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS Residence (
    pid VARCHAR(10),
    street_num VARCHAR(10),
    street_name VARCHAR(25),
    city VARCHAR(20),
    state VARCHAR(15),
    zipcode INT(5),
    x_coords INT(5),
    y_coords INT(5),
    
    PRIMARY KEY (pid, street_num, street_name, city, state, zipcode, x_coords, y_coords),
    FOREIGN KEY(pid,street_num, street_name, city, state, zipcode) REFERENCES Place(pid,street_num, street_name, city, state, zipcode)

);


CREATE TABLE IF NOT EXISTS Resides (
    ID VARCHAR(10),
    pid VARCHAR(10),
    street_num VARCHAR(10),
    street_name VARCHAR(25),
    city VARCHAR(20),
    state VARCHAR(15),
    zipcode INT(5),
    x_coords INT(5),
    y_coords INT(5),
    PRIMARY KEY (ID, pid, street_num, street_name, city, state, zipcode, x_coords, y_coords),
    FOREIGN KEY(ID) REFERENCES Folk(ID) ON DELETE CASCADE,
    FOREIGN KEY(pid,street_num, street_name, city, state, zipcode) REFERENCES Place(pid,street_num, street_name, city, state, zipcode)
);








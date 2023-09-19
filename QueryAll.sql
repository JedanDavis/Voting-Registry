#1 Retrieve the first name, last name, city, and email for each folk.
#SELECT first_name, last_name, city,email FROM Folk NATURAL INNER JOIN Folk_Email;

#2 Presents the number of folks in a given city and their respective state. 
#SELECT COUNT(ID),city, state FROM Folk NATURAL INNER JOIN Place GROUP BY city, state ORDER BY COUNT(ID) DESC;

#3 Presents the number of folks in a given city and their respective state 
#SELECT state, COUNT(pid) AS NUM_INHABITED FROM Place GROUP BY state ORDER BY state ASC;

#4 Retrieves the Voter IDs of folks that registered a voting date between September 1, 2022, and October 5, 2022.
#SELECT DISTINCT ID AS Voter_ID FROM Voting_Registry WHERE Voting_Date BETWEEN '2022-09-01' AND '2022-10-05';

#5 Find for a given month, the number of unique registrations at any voting
#center which is within 5 miles from the center of Megapolis, except for voting
#centers in a given (exclusion) list of voting centers. 

#SELECT Unique_Acronym, COUNT(DISTINCT ID) 
#FROM Voting_Registry NATURAL JOIN (Voting_Center NATURAL INNER JOIN Place) 
#WHERE  SQRT(POWER((x_coords-0),2) +POWER((y_coords-0),2))<6 AND Unique_Acronym
#NOT IN (SELECT Unique_Acronym FROM Voting_Center WHERE state ='NH')
#GROUP BY Unique_Acronym;

#6 Identifies the Unique Acronym of the voting center located in Atkinson with the highest number of registered individuals.
#SELECT COUNT(DISTINCT ID) AS ID_COUNT, Unique_Acronym 
#FROM Voting_Registry NATURAL JOIN (Voting_Center NATURAL JOIN Place) 
#WHERE Voting_Date BETWEEN '2022-09-01' AND '2022-10-05' AND city= 'ATKINSON' 
#GROUP BY Unique_Acronym ORDER BY ID_COUNT DESC LIMIT 1;

#7 Finds the folk id of folks that registered at all voting centers
#WITH VC_RESGISTERED AS (SELECT COUNT( Unique_Acronym) AS VC_count, ID FROM Voting_Registry GROUP BY ID)
#SELECT ID FROM VC_RESGISTERED WHERE VC_count>=(SELECT COUNT(Unique_Acronym) FROM Voting_Center);


#8 It establishes Folk addresses, considering their unique IDs and corresponding coordinates.
#It defines Voting Center addresses, taking into account their Unique Acronyms and coordinates.
#It calculates the distance between each Folk and the closest Voting Center.
#It identifies the closest Voting Center for each Folk based on the computed distances.
#Finally, it selects distinct IDs from the Voting_Registry table that are not in the list of IDs associated with the closest Voting Centers.

#WITH FOLK_ADDRESS AS (SELECT DISTINCT ID, x_coords AS ID_X, Y_coords AS ID_Y FROM (Voting_Registry NATURAL INNER JOIN Folk) NATURAL JOIN Place),

#VC_ADDRESS AS(SELECT DISTINCT Unique_Acronym, x_coords, Y_coords FROM (Voting_Registry NATURAL INNER JOIN Voting_Center) NATURAL JOIN Place),

#DISTANCE AS (SELECT DISTINCT ID, Unique_Acronym, SQRT(POWER((x_coords-ID_X),2) +POWER((y_coords-ID_Y),2)) AS DISTANCE_TO_VC FROM FOLK_ADDRESS NATURAL INNER JOIN VC_ADDRESS),

#CLOSEST AS (SELECT DISTINCT ID, Unique_Acronym FROM DISTANCE WHERE (ID,DISTANCE_TO_VC) IN (SELECT ID,(MIN(DISTANCE_TO_VC)) FROM DISTANCE GROUP BY ID))

#SELECT DISTINCT ID FROM Voting_Registry WHERE ID NOT IN (SELECT DISTINCT ID FROM CLOSEST NATURAL INNER JOIN Voting_Registry);

#9 This function aims to determine the Unique Acronym of the closest available voting center for a specified Folk ID.
#DELIMITER $$
#DROP FUNCTION IF EXISTS ClosestAvailable;

#CREATE FUNCTION ClosestAvailable(Folk_ID VARCHAR(15))
#    RETURNS VARCHAR(10)
#	CONTAINS SQL READS SQL DATA
    
#BEGIN 

#DECLARE VotingCenter VARCHAR(15);
#WITH FOLK_ADDRESS AS (SELECT DISTINCT ID, x_coords AS ID_X, Y_coords AS ID_Y FROM (Voting_Registry NATURAL INNER JOIN Folk) NATURAL JOIN Place WHERE ID = Folk_ID),
#VC_ADDRESS AS(SELECT DISTINCT Unique_Acronym, x_coords, Y_coords FROM (Voting_Registry NATURAL INNER JOIN Voting_Center) NATURAL JOIN VC_Operating_periods NATURAL JOIN Place 
#WHERE '2022-9-15' between start_at and end_at),
#DISTANCE AS (SELECT DISTINCT ID, Unique_Acronym, SQRT(POWER((x_coords-ID_X),2) +POWER((y_coords-ID_Y),2)) AS DISTANCE_TO_VC FROM FOLK_ADDRESS NATURAL INNER JOIN VC_ADDRESS)
#SELECT DISTINCT Unique_Acronym INTO @VotingCenter FROM DISTANCE WHERE (ID, DISTANCE_TO_VC) IN (SELECT ID, (MIN(DISTANCE_TO_VC)) FROM DISTANCE GROUP BY ID);
#RETURN VotingCenter;

#END$$
#DELIMITER ;


#10 retrives the voting center acronym where votes were casted for the ballot 719885386 as well as the answers selected and number of folks that selected that answer for the respective voting center.
#SELECT  Unique_Acronym, Answer,COUNT( ID) FROM Cast_Vote NATURAL INNER JOIN Voting_Registry WHERE Ballot_ID = 719885386 GROUP BY Unique_Acronym, Answer;

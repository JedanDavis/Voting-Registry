# Voter Registry Database

This repository contains the files and scripts necessary to create and manage a voter registry database. The database is designed to handle information related to persons, election staff, voting centers, and more. Below is an overview of the key components and instructions for setting up and using the database.

## Table of Contents

1. [Database Schema Overview](#database-schema-overview)
2. [File Descriptions](#file-descriptions)
3. [Instructions](#instructions)
4. [Queries and Testing](#queries-and-testing)
5. [Additional Notes](#additional-notes)

---

## Database Schema Overview

The database schema consists of several entities and relationships, including:

- **Persons**: Representing individuals who can be either folk, election staff, or both.
- **Folk and Election Staff**: Subtypes of persons, with overlapping participation.
- **Place**: Representing locations which can be either residence or voting center, but not both.
- **Residence and Voting Center**: Subtypes of places, with disjoint participation.
- **Election Staff Roles**: Including judges, clerks, administrators, and monitors, with overlapping participation.
- **Scheduled**: Relating election staff members to voting centers and their assigned roles.
- **Voter Registry**: Connecting persons to voting centers and cast votes.

---

## File Descriptions

- `createDatabase.sql`: SQL script to create the initial structure of the database.
- `createAll.sql`: SQL script to create all tables.
- `loadAll.sql`: SQL script to load data into the tables.
- `dropAll.sql`: SQL script to drop all tables (use with caution).
- `QueryAll.sql`: Contains various queries, each commented for query isolation.
- `Test.sql`: Contains test queries for transactional and functional testing.
- `Transaction.sql`: Contains the repeatable reads transaction.

---

## Instructions

1. **Database Setup**:
   - Execute `createDatabase.sql` to initialize the database schema.
   - Run `createAll.sql` to create all necessary tables.
   - Use `loadAll.sql` to populate tables with initial data.
   - Note: Use `dropAll.sql` with caution, as it drops all tables.

2. **Queries and Testing**:
   - `QueryAll.sql` contains various queries. Uncomment and execute the desired query.
   - `Test.sql` contains test queries. Uncomment and execute for testing purposes.

3. **Transaction**:
   - `Transaction.sql` contains the repeatable reads transaction. Use as needed.

---

## Additional Notes

- Ensure to follow the provided instructions in the correct order to set up and use the database.
- Refer to `Voter_Registry.ipynb` for Jupyter notebook file with a description of each cell's functionality.


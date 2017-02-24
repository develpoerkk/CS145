drop table if exists CurrentTime;
create table CurrentTime (
CurrTime text primary key
);
insert into CurrentTime values( '2001-12-20 00:00:01' );

drop table if exists Categories;
create table Categories ( 
ItemID integer,
Category text,
primary key( ItemID, Category ),
foreign key( ItemID ) references Items( ItemID )
);

drop table if exists Users;
create table Users (
UserID text primary key,
Rating integer,
Location text,
Country text
);

drop table if exists Bids;
create table Bids (
ItemID integer,
UserID text,
Time text,
Amount real,
primary key ( ItemID, Time ),
foreign key ( ItemID ) references Items( ItemID ),
foreign key ( UserID ) references Users( UserID ),
unique( ItemID, UserID, Amount )
);

drop table if exists Items;
create table Items (
ItemID integer primary key,
UserID text,
Name text,
Buy_Price real,
First_Bid real,
Currently real,
Number_of_Bids integer,
Started text,
Ends text,
Description text,
foreign key ( UserID ) references Users( UserID ),
constraint check_started_ends check (started < ends)
);

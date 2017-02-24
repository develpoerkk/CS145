drop table if exists catItem;
create table catItem (
catName text,
ItemID integer,
primary key ( catName, ItemID )
foreign key ( catName ) references item( ItemID ),
foreign key ( ItemID ) references category( catName )
);

drop table if exists category;
create table category ( 
catName text primary key 
);

drop table if exists user;
create table user (
UserID text primary key,
Rating integer,
Location text,
Country text
);

drop table if exists bid;
create table bid (
ItemID integer,
UserID text,
Time text,
Amount real,
primary key ( ItemID, UserID, Time ),
foreign key ( ItemID ) references item( ItemID ),
foreign key ( UserID ) references user( UserID )
);

drop table if exists sell;
create table sell (
ItemID integer primary key,
UserID text,
foreign key ( UserID ) references user( UserID )
);

drop table if exists item;
create table item (
ItemID integer primary key,
Name text,
Started text,
Ends text,
Number_of_Bids integer,
First_Bid real,
Currently real,
Buy_Price real,
Description text 
);

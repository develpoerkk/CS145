-- constraints_verify.sql
-- used for verifying referential integrity
-- created by Rao on Nov 12, 2016

-- verify constraint 5: Categories.ItemID references Items.ItemID
select *
from Categories
where not exists(
	select *
	from Items
	where Items.ItemID = Categories.ItemID
);

-- verify constraint 4: Bids.ItemID references Items.ItemID
select *
from Bids
where not exists(
	select *
	from Items
	where Items.ItemID = Bids.ItemID
);

-- verify constraint 2: Bids.UserID references Users.UserID
select *
from Bids
where not exists(
	select *
	from Users
	where Users.UserID = Bids.UserID
);

-- verify constraint 2: Items.UserID references Users.UserID
select *
from Items
where not exists(
	select *
	from Users
	where Items.UserID = Users.UserID
);

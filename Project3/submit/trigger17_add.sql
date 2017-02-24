-- description: 17. A new bid cannot be inserted to Bids table if its Buy_Price has already been reached.
PRAGMA foreign_keys = ON;
drop trigger if exists trigger17;
create trigger trigger17
before insert on Bids
for each row
when exists (
        Select * 
        from Items
        where 
	Items.Currently >= Items.Buy_Price and
        Items.ItemID = new.ItemID 
)
begin
  select raise(rollback, 'A new bid cannot be inserted to Bids table if its Buy_Price has already been reached.');
end;

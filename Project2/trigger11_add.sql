-- description: 11. No auction may have a bid before its start time or after its end time.
PRAGMA foreign_keys = ON;
drop trigger if exists trigger11;
create trigger trigger11
before insert on Bids
for each row
when exists (
        Select * 
        from Items
        where 
	(new.Time < Items.Started or
	new.Time > Items.Ends) and
	Items.ItemID = new.ItemID
)
begin
  select raise(rollback, 'No auction may have a bid before its start time or after its end time.');
end;

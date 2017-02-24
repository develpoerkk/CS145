-- description: 9. A user may not bid on an item he or she is also selling.
PRAGMA foreign_keys = ON;
drop trigger if exists trigger09;
create trigger trigger09
before insert on Bids
for each row
when exists (
        Select * 
        from Items
        where 
	Items.UserID = new.UserID and
	Items.ItemID = new.ItemID
)
begin
  select raise(rollback, 'A user may not bid on an item he or she is also selling.');
end;

-- description: 14. Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.
PRAGMA foreign_keys = ON;
drop trigger if exists trigger14;
create trigger trigger14
before insert on Bids
for each row
when exists (
        Select * 
        from Items
        where 
	Items.Currently >= new.Amount and
	Items.ItemID = new.ItemID
)
begin
  select raise(rollback, 'Any new bid for a particular item must have a higher amount than any of the previous bids for that particular item.');
end;


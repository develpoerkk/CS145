-- description: 8. The Current Price of an item must always match the Amount of the most recent bid for that item.
PRAGMA foreign_keys = ON;
drop trigger if exists trigger08;
create trigger trigger08
after insert on Bids
for each row
begin
  update Items 
  set Currently = new.Amount
  where
  Items.ItemID = new.ItemID;
end;

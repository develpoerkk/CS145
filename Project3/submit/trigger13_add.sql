-- description: 13. In every auction, the Number of Bids attribute corresponds to the actual number of bids for that particular.
PRAGMA foreign_keys = ON;
drop trigger if exists trigger13;
create trigger trigger13
after insert on Bids
for each row
begin
  update Items 
  set Number_of_Bids = Number_of_Bids + 1
  where
  Items.ItemID = new.ItemID;
end;

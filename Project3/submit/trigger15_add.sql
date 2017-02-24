-- description: 15. All new bids must be placed at the time which matches the current time of your AuctionBase system.
PRAGMA foreign_keys = ON;
drop trigger if exists trigger15;
create trigger trigger15
before insert on Bids
for each row
when exists (
        Select * 
        from CurrentTime
        where 
	CurrentTime.CurrTime <> new.Time 
)
begin
  select raise(rollback, 'All new bids must be placed at the time which matches the current time of your AuctionBase system.');
end;



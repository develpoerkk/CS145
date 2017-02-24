-- description: 16. The current time of your AuctionBase system can only advance forward in time, not backward in time.
PRAGMA foreign_keys = ON;
drop trigger if exists trigger16_insert;
create trigger trigger16_insert
before insert on CurrentTime 
for each row
begin
  select raise(rollback, 'The current time of your AuctionBase system can only advance forward in time, not backward in time.');
end;

drop trigger if exists trigger16_delete;
create trigger trigger16_delete
before delete on CurrentTime
for each row
begin
  select raise(rollback, 'The current time of your AuctionBase system can only advance forward in time, not backward in time.');
end;

drop trigger if exists trigger16_update;
create trigger trigger16_update
before update of CurrTime on CurrentTime
for each row
when exists(
	select *
	from CurrentTime
	where
	CurrentTime.CurrTime >= new.CurrTime 
)
begin
  select raise(rollback, 'The current time of your AuctionBase system can only advance forward in time, not backward in time.');
end;

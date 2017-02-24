select i1.ItemID as answer_4
from item i1
where Currently in (
    select max(Currently)
    from item
    );
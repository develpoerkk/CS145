select count(distinct c1.ItemID) as answer_3
from catItem c1
where c1.ItemID in (
    select c2.ItemID
    from catItem c2 
    group by c2.ItemID 
    having count(c2.catName) = 4
    );
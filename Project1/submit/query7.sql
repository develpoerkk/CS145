select count( distinct( catItem.catName ) ) as answer_7
from catItem 
where catName in (
    select catItem.catName
    from catItem, item, bid
    where catItem.ItemID = item.ItemID and item.ItemID = bid.ItemID
    group by catItem.catName
    having max(bid.Amount) > 100
    );
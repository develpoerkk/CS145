select count( distinct( bid.UserID ) ) as answer_6
from bid, sell
where sell.UserID = bid.UserID;
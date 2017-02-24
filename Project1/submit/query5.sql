select count( distinct sell.UserID ) as answer_5
from sell, user
where sell.UserID = user.UserID and user.rating > 1000;
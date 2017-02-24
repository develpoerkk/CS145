import web

db = web.database(dbn='sqlite',
        db='myData.db' #TODO: add your SQLite database filename
    )

######################BEGIN HELPER METHODS######################

# Enforce foreign key constraints
# WARNING: DO NOT REMOVE THIS!
def enforceForeignKey():
    db.query('PRAGMA foreign_keys = ON')

# initiates a transaction on the database
def transaction():
    return db.transaction()
# Sample usage (in auctionbase.py):
#
# t = sqlitedb.transaction()
# try:
#     sqlitedb.query('[FIRST QUERY STATEMENT]')
#     sqlitedb.query('[SECOND QUERY STATEMENT]')
# except Exception as e:
#     t.rollback()
#     print str(e)
# else:
#     t.commit()
#
# check out http://webpy.org/cookbook/transactions for examples

# returns the current time from your database
def getTime():
    # TODO: update the query string to match
    # the correct column and table name in your database
    query_string = 'select CurrTime from CurrentTime'
    results = query(query_string)
    # alternatively: return results[0]['currenttime']
    return results[0].CurrTime    # TODO: update this as well to match the
                                  # column name

def setTime(time):
    updatedTime = 0
    t = transaction()
    try:
		query_string = 'UPDATE CurrentTime SET CurrTime = $time'
		updatedTime = db.query(query_string, {'time': time})
    except Exception as e:
        t.rollback()
#       print str(e)
    else:
        t.commit()
    return updatedTime

# returns a single item specified by the Item's ID in the database
# Note: if the `result' list is empty (i.e. there are no items for a
# a given ID), this will throw an Exception!
def getItemById(itemID, userID, category, description, minPrice, maxPrice, status):
    # TODO: rewrite this method to catch the Exception in case `result' is empty

    # DEAL WITH ITEMID, USERID, MINPRICE, MAXPRICE
    query_string = 'select * from Items as i, Categories as c where i.ItemID = c.ItemID'
    if itemID:
        query_string += ' and i.ItemID = $itemID'
    if userID:
        query_string += ' and UserID = $userID'
    if category:
        query_string += ' and Category = $category'
    if description:
        query_string += ' and Description like $description'
    if minPrice:
        query_string += ' and Currently >= $minPrice'
    if maxPrice:
        query_string += ' and Currently <= $maxPrice'
    
    # DEAL WITH STATUS
    now = getTime()
    if status == 'open':
        query_string += ' and Started <= $now and $now <=Ends'
    elif status == 'close':
        query_string += ' and Ends < $now'
    elif status == 'notStarted':
        query_string += ' and $now < Started'
    else:
        pass

    # DEAL WITH DUPLICATES IN DIFFERENT CATEGORY
    query_string += ' group by i.ItemID'

    # DEAL WITH OUTPUT FORMAT
    results = query(query_string, {'itemID': itemID, 'userID': userID, 'minPrice': minPrice, 'maxPrice': maxPrice, 'now': now, 'category': category, 'description': "%{0}%".format(description)})
    show_results = []
    for result in results:
        itemInfo = {}
        itemInfo['ItemID'] = result.ItemID
        itemInfo['Name'] = result.Name
        itemInfo['Currently'] = result.Currently
        itemInfo['Buy_Price'] = result.Buy_Price
        show_results.append(itemInfo)        

    # RETURN TO AUCTIONBASE.PY
    return show_results

def addBid(itemID, userID, price):
    addedBid = 0
    query_string = 'insert into Bids (ItemID, UserID, Time, Amount) values ($itemID, $userID, $now, $price)'
    now = getTime()
    t = transaction()
    try:
        addedBid = db.query(query_string, {'itemID': itemID, 'userID': userID, 'now': now, 'price': price})
    except Exception as e:
        t.rollback()
#       print str(e)
    else:
        t.commit()
    return addedBid

def detailsOfId(itemID):
    query_string = 'select * from Items where ItemID = $itemID'
    details = query(query_string, {'itemID': itemID})
    return details

def biddersOfId(itemID):
    query_string = 'select b.UserID, b.Time, b.Amount from Items as i, Bids as b where i.ItemID = b.ItemID and i.ItemID = $itemID'
    bidders = query(query_string, {'itemID': itemID})
    return bidders

def statusOfId(itemID):
    # DEAL WITH STATUS INFORMATION
    now = getTime()
    query_string_1 = 'select * from Items where ItemID = $itemID and $now < Started'
    result_1 = query(query_string_1, {'now': now, 'itemID': itemID})
    query_string_2 = 'select * from Items where ItemID = $itemID and Ends < $now'
    result_2 = query(query_string_2, {'now': now, 'itemID': itemID})
    query_string_3 = 'select * from Items where ItemID = $itemID and Currently >= Buy_Price'
    result_3 = query(query_string_3, {'itemID': itemID})
    status = ''
    if result_1:
        status = 'Not Started.'
    elif result_2 or result_3:
        status = 'Already Closed.'
        query_string_4 = 'select b.UserID from Items as i, Bids as b where i.ItemID = $itemID and b.ItemID = i.ItemID and b.Amount = i.Currently'
        result_4 = query(query_string_4, {'itemID': itemID})
        if result_4:
            status += ' UserID of the Winner: %s.' % (result_4[0].UserID)
        else:
            status += ' No Bidder.' 
    else:
        status = 'Open.'
    return status

def categoriesOfId(itemID):
    query_string = 'select c.Category from Items as i, Categories as c where i.ItemID = $itemID and c.ItemID = i.ItemID'
    results = query(query_string, {'itemID': itemID})
    return results

def sellerOfId(itemID):
    query_string = 'select u.UserID, u.Location, u.Rating, u.Country from Items as i, Users as u where i.ItemID = $itemID and u.UserID = i.UserID'
    results = query(query_string, {'itemID': itemID})
    return results
    

# wrapper method around web.py's db.query method
# check out http://webpy.org/cookbook/query for more info
def query(query_string, vars = {}):
    return list(db.query(query_string, vars))

#####################END HELPER METHODS#####################

#TODO: additional methods to interact with your database,
# e.g. to update the current time


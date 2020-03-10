import redis

#连接池使用
#存车牌与id对应关系
POOL_DB_TWO = redis.ConnectionPool(host='127.0.0.1',port=6379 ,db=2,max_connections=1000)
#存視頻內的人流量與車流量
POOL_DB_FOUR = redis.ConnectionPool(host='127.0.0.1',port=6379 ,db=4,max_connections=1000)

ONE_MONTH = 2592000
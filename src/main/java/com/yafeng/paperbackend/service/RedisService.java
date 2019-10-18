package com.yafeng.paperbackend.service;

import com.google.gson.Gson;
import com.yafeng.paperbackend.config.Redis.KeyPrefix;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

@Service
public class RedisService {

    @Autowired
    private JedisPool jedisPool;

    Gson gson = new Gson();

    /**
     * get
     * @description 从连接池中获取连接 并根据key查找需要的内容 查找完成之后将连接返回到连接池之中
     * @param key 查询条件
     * @param clazz 查找内容
     * @return T
     * @author liugaoyang
     * @date 2019/7/7 16:15
     * @version 1.0.0
     */
    public <T> T get(KeyPrefix keyPrefix, String key, Class<? extends T> clazz ){
        Jedis jedis = null;
        try{
            jedis = jedisPool.getResource();
            key = keyPrefix.prefix() + key;
            String str = jedis.get(key);
            T t = stringToBean(str, clazz);
            return t;

        }finally {
            returnToPool(jedis);
        }

    }

    public <T> boolean set(KeyPrefix keyPrefix, String key, T value){
        Jedis jedis = null;
        try{
            jedis = jedisPool.getResource();
            String str = beanToString(value);
            if (StringUtils.isEmpty(str)){
                return false;
            }
            key = keyPrefix.prefix() + key;
            int seconds = keyPrefix.expireSeconds();
            if (seconds <= 0){
                jedis.set(key, str);
            }else {
                jedis.setex(key, seconds, str);
            }
            return true;

        }finally {
            returnToPool(jedis);
        }
    }

    public boolean delete(KeyPrefix keyPrefix, String key){
        Jedis jedis = null;
        try{
            jedis = jedisPool.getResource();
            key = keyPrefix.prefix() + key;
            long ret = jedis.del(key);
            return ret > 0;
        }
        finally {
            returnToPool(jedis);
        }
    }

    public long incr(KeyPrefix keyPrefix, String key){
        Jedis jedis = null;
        try{
            jedis = jedisPool.getResource();
            key = keyPrefix.prefix() + key;
            return jedis.incr(key);

        }finally {
            returnToPool(jedis);
        }
    }

    public long decr(KeyPrefix keyPrefix, String key){
        Jedis jedis = null;
        try{
            jedis = jedisPool.getResource();
            key = keyPrefix.prefix() + key;
            return jedis.decr(key);

        }finally {
            returnToPool(jedis);
        }
    }

    private void returnToPool(Jedis jedis){
        if (jedis != null){
            jedis.close();
        }
    }

    // 反序列化操作
    public  <T> T stringToBean(String str, Class< ?extends T> clazz){
        if (StringUtils.isEmpty(str)|| clazz == null){
            return null;
        }
        return gson.fromJson(str, clazz);
    }

    // 序列化操作
    public  <T> String beanToString(T value){
        if (value == null){
            return null;
        }
        return gson.toJson(value);

    }

    public <T> boolean exists(KeyPrefix prefix, String key) {
        Jedis jedis = null;
        try {
            jedis =  jedisPool.getResource();
            //生成真正的key
            String realKey  = prefix.prefix() + key;
            return  jedis.exists(realKey);
        }finally {
            returnToPool(jedis);
        }
    }

}

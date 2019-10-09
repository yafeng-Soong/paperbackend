package com.paperweb.hunshuaweb;

import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
import com.baomidou.mybatisplus.generator.config.GlobalConfig;
import com.baomidou.mybatisplus.generator.config.PackageConfig;
import com.baomidou.mybatisplus.generator.config.StrategyConfig;
import com.baomidou.mybatisplus.generator.config.rules.DbType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;

/**
 * mybatis代码生成工具
 * @Author KONG
 * @Date 2019/10/9 15:08
 */
public class MybatisPlusGenerate {
    public static void main(String[] args) {
        AutoGenerator mpg = new AutoGenerator();
        mpg.setGlobalConfig(new GlobalConfig()
                .setFileOverride(true).setOutputDir("")
                .setIdType(IdType.AUTO).setBaseResultMap(true)
                .setAuthor("KONG")
                .setControllerName("%sController").setServiceName("MP%sService").setServiceImplName("%sServiceImpl").setMapperName("%sEntity").setXmlName("%sMapper"));
        mpg.setDataSource(new DataSourceConfig()
                .setUsername("").setPassword("")
                .setDbType(DbType.MYSQL).setDriverName("")
                .setUrl("")
        );
        mpg.setPackageInfo(new PackageConfig()
                .setParent("com.yafeng.paperweb.test")
                .setController("controller").setService("service").setServiceImpl("service.impl").setEntity("entity").setMapper("mapper"));
        mpg.setStrategy(new StrategyConfig()
                .setNaming(NamingStrategy.underline_to_camel)
                .setRestControllerStyle(true));
        mpg.execute();

    }
}
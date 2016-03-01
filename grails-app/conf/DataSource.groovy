dataSource {
    logSql = true
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = "1234" //"root"
    dialect = org.hibernate.dialect.MySQL5InnoDBDialect
    properties {
        maxActive = 50
        maxIdle = 25
        minIdle = 5
        initialSize = 5
        minEvictableIdleTimeMillis = 1800000
        timeBetweenEvictionRunsMillis = 1800000
        maxWait = 10000
        ValidationQuery = 'select 1'
    }
}

hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:mysql://localhost/wbbf-training?useOldAliasMetadataBehavior=true"
        }
    }
}
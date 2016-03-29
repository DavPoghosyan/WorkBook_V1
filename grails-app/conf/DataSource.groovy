dataSource {
    logSql = true
    pooled = true
    driverClassName = "com.mysql.jdbc.Driver"
    username = "root"
    password = "root" //"1234"
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
    cache.use_second_level_cache = false
    cache.use_query_cache = false
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:mysql://localhost/training?useOldAliasMetadataBehavior=true"
        }
    }
    test {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:mysql://localhost/trainingTest?useOldAliasMetadataBehavior=true"
        }
    }
    production {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:mysql://localhost/trainingProd?useOldAliasMetadataBehavior=true"
        }
    }

}
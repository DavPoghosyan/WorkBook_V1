// Place your Spring DSL code here
import org.springframework.aop.scope.ScopedProxyFactoryBean

beans = {
    xmlProcessingServiceProxy(ScopedProxyFactoryBean) {
        targetBeanName = 'xmlProcessingService'
        proxyTargetClass = true
    }
}

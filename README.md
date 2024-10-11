# springcloud-openfeign-demo
学习springcloud、nacos、openfeign 基础demo
## 目前执行流程
- order服务通过nacos+openfeign调用用户服务

## 注意事项
- 每个服务的`bootstrap.yml`文件，配置了nacos命名空间。与其他项目隔离。如果之前没有用过nacos,自行去除。
```yml
spring:
  application:
    name: userservice
  profiles:
    active: dev
  cloud:
    nacos:
      server-addr: localhost:8848
      config:
        file-extension: yaml
        namespace: 3c7fbd2c-e4e5-4d0e-a2bb-366c865fee33
      discovery:
        namespace: 3c7fbd2c-e4e5-4d0e-a2bb-366c865fee33
```

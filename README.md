# oneDayClass

Spring Boot + JSP + MyBatis 기반 원데이 클래스 프로젝트입니다.

## 프로젝트 구조

```text
src/main/java/com/example/onedayclass
├─ admin
│  └─ controller
├─ clazz
│  ├─ controller
│  ├─ dto
│  ├─ mapper
│  └─ service
├─ common
│  ├─ config
│  ├─ controller
│  ├─ paging
│  └─ storage
├─ controller
├─ levelup
│  ├─ controller
│  ├─ dto
│  ├─ mapper
│  └─ service
├─ member
│  ├─ controller
│  ├─ dto
│  ├─ mapper
│  └─ service
├─ payment
│  ├─ controller
│  ├─ dto
│  ├─ mapper
│  └─ service
├─ qna
│  ├─ controller
│  ├─ dto
│  ├─ mapper
│  └─ service
├─ review
│  ├─ controller
│  ├─ dto
│  ├─ mapper
│  └─ service
└─ security

src/main/resources
├─ application.properties
├─ data.sql
├─ schema.sql
├─ mapper
└─ static
   └─ css

src/main/webapp/WEB-INF/views
├─ admin
├─ class
├─ include
├─ levelup
├─ member
├─ payment
├─ qna
└─ review
```

## 기동 방법

### 요구 사항

- Java 17
- Maven

### 실행

```bash
mvn spring-boot:run
```

### 접속 주소

```text
http://localhost:8080
```

### H2 Console

```text
http://localhost:8080/h2-console
```

### 현재 기본 설정

`src/main/resources/application.properties`

```properties
server.port=8080

spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp

spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.url=jdbc:h2:mem:onedayclassdb;MODE=MySQL;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE
spring.datasource.username=sa
spring.datasource.password=

spring.sql.init.mode=always
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

spring.servlet.multipart.max-file-size=20MB
spring.servlet.multipart.max-request-size=30MB
app.upload.dir=uploads
```

### 업로드 경로

- 업로드 루트: `uploads`
- 클래스 이미지 저장 경로: `uploads/classes`
- 정적 접근 경로: `/uploads/**`

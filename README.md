# oneDayClass

Spring Boot + Maven + JSP 기반의 기본 MVC 구조 샘플입니다.

## 실행 방법

```bash
mvn spring-boot:run
```

브라우저에서 아래 주소로 접속하세요.

```
http://localhost:8080
```

## 구조

- `controller/HomeController.java`: 요청 처리
- `src/main/webapp/WEB-INF/views/home.jsp`: 뷰
- `src/main/resources/application.properties`: JSP 뷰 리졸버 설정

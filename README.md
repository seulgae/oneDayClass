# oneDayClass

`oneDayClass` is a Spring Boot MVC + MyBatis + JSP project for a one-day class platform.
It covers class browsing, reviews, notices, QnA, request boards, payments, level-up requests, and admin approval flows in a single application.

## 1. Overview

- Spring Boot 3 based JSP MVC application
- Default runtime uses `H2 in-memory DB`
- `schema.sql` and `data.sql` are applied at startup
- Security is handled with Spring Security
- Shared JSP layout is organized with common header, footer, and list toolbar fragments

## 2. Tech Stack

- Java 17
- Spring Boot 3.2.5
- Spring MVC
- Spring Security
- MyBatis
- JSP + JSTL
- H2 Database
- Maven

## 3. Main Features

### User Features

- Join, login, logout, mypage, profile edit
- Class list, class detail, class like
- Review create, list, detail
- Notice list and detail
- QnA create, reply, list, detail
- Request board create, reply, list, detail
- Cart, checkout, payment history, payment detail
- Teacher level-up request flow

### Admin Features

- Admin dashboard
- Pending class approval
- Pending level-up request check
- QnA and review status overview

## 4. Recent Updates

- Added Korean inline comments to DTO fields
- Renamed JSP files to match screen purpose consistently
- Updated controller view names to match renamed JSP files
- Added screen description comments at the top of major JSP files
- Replaced internal absolute JSP paths with `c:url`
- Added JSP `@elvariable` hints to reduce IntelliJ `Cannot resolve variable` warnings
- Checked shared JSP files such as `error/common.jsp`, `include/footer.jsp`, and `include/list-toolbar.jspf`
- Applied `Serializable` to `BaseVo` and `MemberPrincipal` for session serialization stability

## 5. Package Structure

```text
src/main/java/com/example/onedayclass
├─ admin
├─ clazz
├─ common
├─ controller
├─ levelup
├─ member
├─ notice
├─ payment
├─ qna
├─ requestboard
├─ review
└─ security
```

Typical domain structure:

- `controller`: web entry point
- `service`: business logic
- `mapper`: MyBatis mapper
- `dto`: data transfer object

## 6. JSP View Structure

```text
src/main/webapp/WEB-INF/views
├─ admin
├─ class
├─ error
├─ include
├─ levelup
├─ member
├─ notice
├─ payment
├─ qna
├─ request
└─ review
```

Shared files:

- `src/main/webapp/WEB-INF/views/include/header.jsp`
- `src/main/webapp/WEB-INF/views/include/footer.jsp`
- `src/main/webapp/WEB-INF/views/include/list-toolbar.jspf`
- `src/main/webapp/WEB-INF/views/error/common.jsp`

Main screen files:

- `class/classList.jsp`
- `class/classDetail.jsp`
- `class/classForm.jsp`
- `review/reviewList.jsp`
- `review/reviewDetail.jsp`
- `review/reviewForm.jsp`
- `qna/qnaList.jsp`
- `qna/qnaDetail.jsp`
- `qna/qnaForm.jsp`
- `qna/qnaReply.jsp`
- `request/requestBoardList.jsp`
- `request/requestBoardDetail.jsp`
- `request/requestBoardForm.jsp`
- `request/requestBoardReply.jsp`
- `payment/paymentCart.jsp`
- `payment/paymentCheckout.jsp`
- `payment/paymentHistory.jsp`
- `payment/paymentDetail.jsp`

## 7. Security and Authorization

Based on `SecurityConfig`:

- Anonymous users can access home, classes, reviews, notices, QnA, request board, and level-up list/detail pages
- Authenticated users can create reviews, QnA posts, QnA replies, request board posts, and request board replies
- `/payments/**` requires login
- Class create, edit, and delete require `TEACHER` or `ADMIN`
- `/admin/**` requires `ADMIN`

Related files:

- `src/main/java/com/example/onedayclass/security/SecurityConfig.java`
- `src/main/java/com/example/onedayclass/common/interceptor/LoginMemberInterceptor.java`
- `src/main/java/com/example/onedayclass/common/controller/GlobalControllerAdvice.java`

## 8. Database and Configuration

Default environment:

- DB: H2 in-memory
- Port: `8080`
- H2 Console: `/h2-console`
- Upload dir: `uploads`

Main config files:

- `src/main/resources/application.properties`
- `src/main/resources/schema.sql`
- `src/main/resources/data.sql`

Important properties:

```properties
server.port=8080
spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp
spring.datasource.url=jdbc:h2:mem:onedayclassdb;MODE=MySQL;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE
spring.h2.console.path=/h2-console
app.upload.dir=uploads
```

## 9. Run

### Development

```bash
mvn spring-boot:run
```

### Package and Run

```bash
mvn -DskipTests package
java -jar target/oneDayClass-0.0.1-SNAPSHOT.jar
```

Default URL:

- `http://localhost:8080`

## 10. Main Routes

- Home: `/`
- Join: `/members/join`
- Login: `/members/login`
- Mypage: `/members/mypage`
- Classes: `/classes`
- Class detail: `/classes/{cNum}`
- Reviews: `/reviews`
- Notices: `/notices`
- QnA: `/qna`
- Request board: `/requests`
- Cart: `/payments/cart`
- Checkout: `/payments/checkout`
- Payment history: `/payments/history`
- Payment detail: `/payments/history/{pNum}`
- Level-up: `/levelups`
- Admin: `/admin`

## 11. Notes

- Major JSP files include top-level screen description comments
- Major JSP files include IntelliJ `@elvariable` hints
- Shared list search UI uses `include/list-toolbar.jspf`
- After serialization-related changes, old sessions may need to be cleared
- If `mvn` is not available in the environment, run Maven from IDE or local installation path

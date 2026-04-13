# oneDayClass

`oneDayClass`는 원데이 클래스 플랫폼을 구현한 Spring Boot 3 기반 MVC 웹 애플리케이션입니다.
JSP 화면, MyBatis 매퍼, Spring Security 인증/인가, H2 시드 데이터, 파일 업로드를 포함하며 클래스 탐색부터 결제, 리뷰, QnA, 요청 게시판, 등업 신청, 관리자 승인까지 한 흐름으로 구성되어 있습니다.

## 1. 프로젝트 개요

- Spring Boot 3.2.5 + JSP + MyBatis 기반 서버 렌더링 애플리케이션
- 기본 실행 DB는 `H2 in-memory`
- 시작 시 `schema.sql`, `data.sql` 자동 실행
- Spring Security 기반 로그인/권한 처리
- 업로드 파일은 `uploads/` 아래에 저장되고 `/uploads/**`로 정적 제공
- 홈 화면에서 추천 클래스, 최근 리뷰, 등업 신청 대기 현황 표시

## 2. 기술 스택

- Java 17
- Spring Boot 3.2.5
- Spring MVC
- Spring Security
- MyBatis Spring Boot Starter 3.0.3
- JSP + JSTL
- H2 Database
- MySQL Connector/J
- Lombok
- Maven

## 3. 현재 구현 기능

### 사용자 기능

- 회원가입, 로그인, 로그아웃, 마이페이지, 회원정보 수정, 회원 탈퇴
- 클래스 목록/상세 조회
- 클래스 검색, 온/오프라인 필터, 추천 클래스 노출
- 강사/관리자 클래스 등록, 수정, 삭제
- 클래스 좋아요
- 리뷰 목록/상세/작성/삭제
- 리뷰 좋아요
- 공지사항 목록/상세
- QnA 목록/상세/작성/답변/삭제
- 요청 게시판 목록/상세/작성/답변/삭제
- 장바구니 추가/삭제
- 결제 진행, 결제 내역 조회, 결제 상세 조회
- 등업 신청 목록/상세/작성/답변/삭제

### 관리자 기능

- 관리자 대시보드
- 승인 대기 클래스 확인 및 승인
- 등업 신청 대기 확인
- 최근 QnA, 리뷰 현황 확인
- 등업 신청 승인

## 4. 현재 코드 기준 핵심 동작

- 홈(`/`)은 추천 온라인 클래스, 오프라인 클래스, 최근 리뷰 3건, 등업 대기 3건을 표시합니다.
- 클래스 등록/수정 시 썸네일과 상세 이미지를 업로드할 수 있습니다.
- 업로드 파일은 `FileStorageService`가 UUID 파일명으로 저장합니다.
- 비밀번호 인코더는 `LegacyAwarePasswordEncoder`를 사용해 평문 시드 데이터와 BCrypt 해시를 모두 지원합니다.
- 로그인 성공 시 세션에 `loginMember`를 저장합니다.
- `LoginMemberInterceptor`가 전체 요청에서 로그인 사용자 정보를 공통 처리하고, 업로드 리소스와 H2 콘솔은 예외 처리합니다.

## 5. 패키지 구조

```text
src/main/java/com/example/onedayclass
|- admin
|- clazz
|- common
|- controller
|- levelup
|- member
|- notice
|- payment
|- qna
|- requestboard
|- review
`- security
```

도메인별 기본 구성:

- `controller`: 웹 요청 진입점
- `service`: 비즈니스 로직
- `mapper`: MyBatis 인터페이스
- `dto`: 화면/비즈니스 전달 객체

## 6. 화면 구조

```text
src/main/webapp/WEB-INF/views
|- admin
|- class
|- error
|- include
|- levelup
|- member
|- notice
|- payment
|- qna
|- request
|- review
`- home.jsp
```

공용 파일:

- `src/main/webapp/WEB-INF/views/include/header.jsp`
- `src/main/webapp/WEB-INF/views/include/footer.jspf`
- `src/main/webapp/WEB-INF/views/include/list-toolbar.jspf`
- `src/main/webapp/WEB-INF/views/error/common.jsp`

주요 화면:

- `home.jsp`
- `admin/adminDashboard.jsp`
- `class/classList.jsp`
- `class/classDetail.jsp`
- `class/classForm.jsp`
- `member/memberLogin.jsp`
- `member/memberJoin.jsp`
- `member/memberMypage.jsp`
- `member/memberEdit.jsp`
- `notice/noticeList.jsp`
- `notice/noticeDetail.jsp`
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
- `levelup/levelUpList.jsp`
- `levelup/levelUpDetail.jsp`
- `levelup/levelUpForm.jsp`
- `levelup/levelUpReply.jsp`

## 7. 보안 및 권한

`SecurityConfig` 기준:

- 누구나 접근 가능
  - `/`
  - `/css/**`
  - `/uploads/**`
  - `/h2-console/**`
  - `/members/login`
  - `/members/join`
  - 클래스/리뷰/공지/QnA/요청 게시판/등업 목록 및 상세 `GET`
- 로그인 필요
  - 클래스 좋아요, 리뷰 좋아요
  - 리뷰 작성/삭제
  - QnA 작성/답변/삭제
  - 요청 게시판 작성/답변/삭제
  - 등업 신청 작성/답변/삭제
  - 마이페이지, 회원정보 수정, 회원 탈퇴
  - 결제 전체(`/payments/**`)
- `TEACHER` 또는 `ADMIN` 권한 필요
  - 클래스 등록, 수정, 삭제
- `ADMIN` 권한 필요
  - `/admin/**`
  - 클래스 승인
  - 등업 승인

관련 파일:

- `src/main/java/com/example/onedayclass/security/SecurityConfig.java`
- `src/main/java/com/example/onedayclass/security/CustomUserDetailsService.java`
- `src/main/java/com/example/onedayclass/security/LegacyAwarePasswordEncoder.java`
- `src/main/java/com/example/onedayclass/common/interceptor/LoginMemberInterceptor.java`
- `src/main/java/com/example/onedayclass/common/controller/GlobalControllerAdvice.java`

## 8. 데이터베이스

주요 테이블:

- `memberList`: 회원/강사/관리자
- `classBBS`: 클래스
- `classLikes`: 클래스 좋아요
- `reviewBBS`: 리뷰
- `reviewLikes`: 리뷰 좋아요
- `qnaBBS`: QnA
- `requestBBS`: 요청 게시판
- `levelUpBBS`: 등업 신청
- `cartList`: 장바구니
- `paymentInfo`: 주문 헤더
- `payComplete`: 결제 완료 항목

기본 데이터 특성:

- 관리자 1명, 일반 회원 1명, 강사 1명이 시드로 들어갑니다.
- 클래스, 공지성 QnA, 일반 QnA, 리뷰, 등업 신청, 요청 게시판 샘플 데이터가 포함되어 있습니다.
- 클래스 썸네일/상세 이미지는 `uploads/classes/` 아래 SVG 샘플 파일을 사용합니다.

샘플 로그인 계정:

- 관리자: `admin / 12341234`
- 일반회원: `user1 / 12341234`
- 강사: `user2 / 12341234`

참고:

- 시드 비밀번호는 평문으로 저장되어 있지만 `LegacyAwarePasswordEncoder`가 호환 처리합니다.
- 회원 등급은 일반회원 `1`, 강사 `2`, 관리자 `3`을 사용합니다.

## 9. 설정 값

`src/main/resources/application.properties` 기준:

```properties
spring.application.name=oneDayClass
server.port=8080

spring.mvc.view.prefix=/WEB-INF/views/
spring.mvc.view.suffix=.jsp
spring.mvc.hiddenmethod.filter.enabled=true

spring.datasource.driver-class-name=org.h2.Driver
spring.datasource.url=jdbc:h2:mem:onedayclassdb;MODE=MySQL;DB_CLOSE_DELAY=-1;DB_CLOSE_ON_EXIT=FALSE
spring.datasource.username=sa
spring.datasource.password=
spring.sql.init.mode=always
spring.h2.console.enabled=true
spring.h2.console.path=/h2-console

mybatis.type-aliases-package=com.example.onedayclass
mybatis.mapper-locations=classpath:/mapper/*.xml
mybatis.configuration.map-underscore-to-camel-case=true

spring.servlet.multipart.max-file-size=20MB
spring.servlet.multipart.max-request-size=30MB
app.upload.dir=uploads
```

## 10. 주요 라우트

- 홈: `/`
- 회원가입: `/members/join`
- 로그인: `/members/login`
- 마이페이지: `/members/mypage`
- 회원정보 수정: `/members/edit`
- 클래스 목록: `/classes`
- 클래스 상세: `/classes/{cNum}`
- 클래스 등록: `/classes/new`
- 리뷰 목록: `/reviews`
- 리뷰 상세: `/reviews/{rNum}`
- 리뷰 작성: `/reviews/new`
- 공지사항 목록: `/notices`
- 공지사항 상세: `/notices/{qNum}`
- QnA 목록: `/qna`
- QnA 상세: `/qna/{qNum}`
- 요청 게시판 목록: `/requests`
- 요청 게시판 상세: `/requests/{reqNum}`
- 장바구니: `/payments/cart`
- 결제: `/payments/checkout`
- 결제 내역: `/payments/history`
- 결제 상세: `/payments/history/{pNum}`
- 등업 신청 목록: `/levelups`
- 등업 신청 상세: `/levelups/{lvlNum}`
- 관리자 대시보드: `/admin`

## 11. 실행 방법

### 개발 실행

```bash
mvn spring-boot:run
```

### 패키징 후 실행

```bash
mvn -DskipTests package
java -jar target/oneDayClass-0.0.1-SNAPSHOT.jar
```

기본 접속 주소:

- `http://localhost:8080`
- H2 콘솔: `http://localhost:8080/h2-console`
# oneDayClass

`Proj_OnedayClass` 레거시 JSP Model1 프로젝트를 현재 프로젝트로 옮기면서 Spring MVC 패턴으로 재구성한 리팩토링 작업본이다.

기존 구조는 JSP가 화면, 요청 처리, DB 접근을 직접 담당하는 방식이었고, 현재 구조는 다음 계층으로 분리되어 있다.

- `controller`: 요청 진입점
- `service`: 비즈니스 로직
- `mapper`: MyBatis DB 접근
- `dto`: 화면/서비스/DB 간 데이터 전달
- `JSP views`: 화면 렌더링

## Refactor Scope

다음 레거시 기능을 기준으로 Spring MVC 구조를 만들었다.

- 회원
- 클래스
- 리뷰
- QnA
- 장바구니 / 결제
- 강사 승급 요청
- 관리자 승인 화면

## Project Structure

주요 소스 구조는 아래와 같다.

```text
src/main/java/com/example/onedayclass
├─ admin/controller
├─ clazz
│  ├─ controller
│  ├─ dto
│  ├─ mapper
│  └─ service
├─ common/controller
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
└─ review
   ├─ controller
   ├─ dto
   ├─ mapper
   └─ service

src/main/resources
├─ application.properties
├─ mapper
└─ static/css

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

## Legacy Mapping

레거시의 `pack_*` 구조는 대략 아래처럼 대응된다.

- `pack_Member` -> `member`
- `pack_ClassBBS` -> `clazz`
- `pack_QnaBBS` -> `qna`
- `pack_reviewBBS` -> `review`
- `pack_Payment` -> `payment`
- `pack_LevelUpBBS` -> `levelup`
- `adminBBS` 관련 JSP -> `admin`

기존 `*Mgr.java` 클래스에 몰려 있던 로직은 Service + Mapper 로 분리했다.

## Key Files

- `pom.xml`
  Spring Boot, JSP, JSTL, MyBatis, MySQL 의존성 설정
- `src/main/resources/application.properties`
  JSP view resolver, datasource, MyBatis 설정
- `src/main/java/com/example/onedayclass/controller/HomeController.java`
  홈 화면 진입
- `src/main/java/com/example/onedayclass/common/controller/GlobalControllerAdvice.java`
  공통 세션 사용자 모델 주입
- `src/main/resources/mapper/*.xml`
  레거시 SQL을 도메인별 MyBatis 매퍼로 정리

## View Pages

현재 JSP 화면은 기능별로 분리되어 있다.

- 홈: `views/home.jsp`
- 회원: `views/member/*`
- 클래스: `views/class/*`
- 리뷰: `views/review/*`
- QnA: `views/qna/*`
- 결제: `views/payment/*`
- 강사 승급: `views/levelup/*`
- 관리자: `views/admin/dashboard.jsp`

공통 레이아웃은 아래 파일을 사용한다.

- `views/include/header.jsp`
- `views/include/footer.jsp`

## Database

DB는 MySQL 기준으로 설정해 두었다.

현재 `application.properties` 값은 임시값이다.

```properties
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.datasource.url=jdbc:mysql://localhost:3306/onedayclassdb?serverTimezone=Asia/Seoul&characterEncoding=UTF-8
spring.datasource.username=root
spring.datasource.password=
```

실제 DB 계정, 비밀번호, 스키마 최종본은 별도로 반영해야 한다.

## Run

Maven 환경이 준비되어 있다면 아래 방식으로 실행한다.

```bash
mvn spring-boot:run
```

기본 주소:

```text
http://localhost:8080
```

## Current Status

현재 상태는 "레거시 구조를 MVC 계층으로 옮긴 1차 리팩토링" 단계다.

반영된 내용:

- 도메인별 패키지 분리
- JSP Model1 -> Spring MVC 전환
- JDBC 직접 호출 구조 -> MyBatis Mapper 전환
- 홈 / 회원 / 클래스 / 후기 / QnA / 결제 / 승급 / 관리자 화면 골격 구성
- 공통 스타일 및 레이아웃 추가

아직 남은 작업:

- 실제 MySQL 접속 정보 반영
- 레거시 SQL과 실제 테이블 컬럼 최종 정합성 검증
- 파일 업로드/다운로드 세부 기능 보완
- 권한 처리 세분화
- Maven 빌드 및 실행 검증

## Notes

- 현재 작업 환경에서는 `mvn` 실행 파일이 없어 실제 빌드 검증은 수행하지 못했다.
- 테스트 클래스는 DB 연결 없이 최소 형태로 유지하고 있다.
- 화면 문구는 우선 동작 가능한 구조 중심으로 정리한 상태다.

# oneDayClass

`oneDayClass`는 원데이 클래스 플랫폼을 주제로 한 Spring Boot MVC + MyBatis + JSP 프로젝트입니다.  
클래스 탐색, 후기, 공지, QnA, 요청게시판, 결제, 등업 요청까지 한 흐름으로 확인할 수 있도록 정리되어 있습니다.

## 1. 프로젝트 개요

- 기존 JSP 중심 구조를 Spring Boot 기반 MVC 구조로 정리한 프로젝트입니다.
- 실행 환경은 `H2 in-memory DB` 기준이며, 서버 시작 시 `schema.sql`, `data.sql`이 함께 반영됩니다.
- UI는 공통 검색 리본, 게시판형 목록, 홈 히어로, 반응형 이미지 중심으로 최근 개편된 상태입니다.

## 2. 기술 스택

- Java 17
- Spring Boot 3.2.5
- Spring MVC
- Spring Security
- MyBatis
- JSP + JSTL
- H2 Database
- Maven

## 3. 주요 기능

### 사용자 기능

- 회원가입, 로그인, 회원정보 수정
- 클래스 목록 조회, 상세 조회
- 장바구니, 결제, 결제 내역/상세 조회
- 사용자 후기 작성 및 조회
- 공지사항 조회
- QnA 게시글 작성 및 댓글/대댓글 작성
- 요청게시판 작성 및 댓글/대댓글 작성
- 강사 등업 요청

### 관리자/운영 기능

- 관리자 페이지 진입
- 클래스 관리
- 등업 요청 확인
- 후기/QnA/요청 데이터 조회 기반 정리

## 4. 최근 반영 사항

- 클래스/QnA/후기 목록 검색 UI를 공통 `list-toolbar.jspf`로 통일
- 공통 검색 리본의 깨진 문자열 복구 및 검색 조건 라벨 정리
- 후기 목록을 게시판형 테이블 UI로 정리
- 후기 검색 조건을 제목/작성자/내용 기준으로 확장
- `BaseVo` 공통 감사 필드 구조 도입
- 감사 컬럼을 주요 DTO 및 Mapper XML에 반영
- QnA를 원글 + 댓글/대댓글 구조로 개편
- 공지사항 게시판 추가
- 요청게시판 추가 및 댓글/대댓글 기능 구현
- 홈 화면 UI/UX 리디자인 및 슬라이더 드래그 지원
- 결제 페이지를 배송 정보 + 결제 요약 구조로 재정리
- 장바구니 기준 결제 금액/배송비/총 결제금액 자동 합산 처리
- 결제내역 상세 페이지(`/payments/history/{pNum}`) 추가
- 헤더 메뉴 재배치 및 등업 요청 버튼을 마이페이지로 이동
- 주요 JSP 한글 깨짐 복구 및 일부 한 줄 파일 포맷 정리
- footer 정렬/배경/하단 배치 스타일 보정
- 시드 데이터 한글 복구 및 클래스 SVG 리소스 정리
- 주요 목록/상세 화면 작성일을 `YYYY-MM-DD` 형식으로 통일
- 회원가입/등록/작성 주요 폼에 브라우저 기본 유효성 검사 속성 보강

## 5. 프로젝트 구조

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

각 도메인은 대체로 아래 구조를 따릅니다.

- `controller`: 요청 진입점
- `service`: 비즈니스 로직
- `mapper`: MyBatis 인터페이스
- `dto`: 화면/서비스/DB 전달 객체

## 6. JSP 뷰 구조

```text
src/main/webapp/WEB-INF/views
├─ admin
├─ class
├─ include
├─ levelup
├─ member
├─ notice
├─ payment
├─ qna
├─ request
└─ review
```

공통 레이아웃 파일:

- `src/main/webapp/WEB-INF/views/include/header.jsp`
- `src/main/webapp/WEB-INF/views/include/footer.jsp`
- `src/main/webapp/WEB-INF/views/include/list-toolbar.jspf`

## 7. 데이터베이스

기본 실행 환경은 `H2 메모리 DB`입니다.

주요 설정 파일:

- `src/main/resources/application.properties`
- `src/main/resources/schema.sql`
- `src/main/resources/data.sql`

현재 스키마 반영 내용:

- 감사 컬럼 `createdDate`, `createdBy`, `updatedDate`, `updatedBy`
- `qnaBBS.parentQNum`
- 요청게시판용 `requestBBS`
- 한국어 시드 데이터

## 8. 게시판 구조

### 공지사항

- 별도 목록/상세 페이지 제공
- QnA와 UI 톤을 맞춘 게시판형 화면

### QnA

- 목록에는 원글만 표시
- 상세에서 댓글/대댓글 표시
- `qDepth`
  - `0`: 원글
  - `1`: 댓글
  - `2`: 대댓글
- `parentQNum`으로 부모 댓글 관계 관리

### 요청게시판

- 필요한 기능, 개선 아이디어, 요청사항을 남기는 게시판
- 목록에는 원글만 표시
- 상세에서 댓글/대댓글 표시
- QnA와 유사한 구조로 구현

### 결제

- 장바구니 기준으로 주문 금액과 배송비를 자동 계산
- 결제 화면에서 배송 정보 입력과 주문 요약을 분리
- 결제 내역 목록에서 주문 상세 페이지로 이동 가능
- 상세 페이지에서 배송 정보, 결제 금액, 주문 상품 목록 확인 가능

## 9. 보안/권한

Spring Security 기반으로 권한을 분리합니다.

- 비로그인 사용자도 홈, 클래스, 공지사항, 후기, QnA, 요청게시판 조회 가능
- 글 작성, 댓글 작성, 장바구니/결제는 로그인 필요
- 클래스 등록/수정/삭제는 `TEACHER`, `ADMIN`
- 관리자 페이지는 `ADMIN`

관련 파일:

- `src/main/java/com/example/onedayclass/security/SecurityConfig.java`
- `src/main/java/com/example/onedayclass/common/interceptor/LoginMemberInterceptor.java`

## 10. 실행 방법

### 기본 실행

```bash
mvn spring-boot:run
```

또는

```bash
mvn -DskipTests package
java -jar target/oneDayClass-0.0.1-SNAPSHOT.jar
```

기본 접속 주소:

- `http://localhost:8080`

H2 콘솔:

- `http://localhost:8080/h2-console`

## 11. 주요 URL

- 홈: `/`
- 클래스 목록: `/classes`
- 클래스 상세: `/classes/{id}`
- 사용자 후기: `/reviews`
- 공지사항: `/notices`
- 문의 QnA: `/qna`
- 요청게시판: `/requests`
- 장바구니: `/payments/cart`
- 결제 내역: `/payments/history`
- 결제 내역 상세: `/payments/history/{pNum}`
- 등업 요청: `/levelups`
- 관리자: `/admin`

## 12. 업로드/리소스

업로드 경로 설정:

```properties
app.upload.dir=uploads
```

현재 클래스 이미지 샘플 리소스는 아래 경로를 사용합니다.

- `uploads/classes`

정적 리소스 스타일 핵심 파일:

- `src/main/resources/static/css/app.css`

## 13. 화면/데이터 참고 포인트

- 홈 화면은 히어로 + 클래스 슬라이더 중심
- 후기/QnA/공지/요청게시판은 게시판형 목록 UI
- 결제 화면은 배송 정보 섹션과 주문 요약 섹션으로 구성
- 작성일 표시는 주요 화면에서 `YYYY-MM-DD` 형식으로 정리
- 시드 데이터 수정 후에는 서버 재시작이 필요

## 14. 확인 권장 순서

처음 프로젝트를 보는 경우 아래 순서로 확인하면 흐름 파악이 쉽습니다.

1. `/`
2. `/classes`
3. `/classes/{id}`
4. `/reviews`
5. `/notices`
6. `/qna`
7. `/qna/{id}`
8. `/requests`
9. `/requests/{id}`
10. `/members/join`
11. `/payments/cart`
12. `/payments/checkout`
13. `/payments/history`
14. `/levelups`
15. `/admin`

## 15. 주의사항

- `data.sql`은 메모리 DB 초기화 기준입니다.
- 시드 데이터 수정 사항은 서버 재시작 후 반영됩니다.
- 로컬 환경에 `mvn`, `java`가 PATH에 없을 수 있어 IDE 번들 경로를 직접 써야 할 수 있습니다.
- 업로드 디렉터리의 SVG는 화면 시연용 샘플 리소스입니다.

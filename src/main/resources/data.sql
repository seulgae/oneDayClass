DELETE FROM cartList;
DELETE FROM payComplete;
DELETE FROM paymentInfo;
DELETE FROM reviewLikes;
DELETE FROM classLikes;
DELETE FROM reviewBBS;
DELETE FROM qnaBBS;
DELETE FROM levelUpBBS;
DELETE FROM requestBBS;
DELETE FROM classBBS;
DELETE FROM memberList;

INSERT INTO memberList (
    uId, uPw, uName, uPhone, uZip, uAddr1, uAddr2, uEmail, uLevel, sName, sSns, createdBy, updatedBy
) VALUES
('admin', '12341234', '관리자', '010-2000-0001', '06123', '서울특별시 강남구 테헤란로', '18층 운영팀', 'admin@onedayclass.local', '3', NULL, NULL, 'admin', 'admin'),
('user1', '12341234', '김하늘', '010-3100-1111', '04052', '서울특별시 마포구 월드컵북로', '101동 1203호', 'user1@onedayclass.local', '1', NULL, NULL, 'user1', 'user1'),
('user2', '12341234', '박서윤', '010-4200-2222', '04799', '서울특별시 성동구 연무장길', '스튜디오 온기', 'user2@onedayclass.local', '2', '온기 클래스랩', '@warm.classlab', 'user2', 'user2');

INSERT INTO classBBS (
    cCode, cTeacher, cUid, cCategory, cTitle, cContent, cRegDate, cPrice, cDelivery,
    cThumbName, cThumbSize, cFileName, cFileSize, cMaxStu, cApplyStu, cArea, cOnoff, cStatus, cLikes,
    createdBy, updatedBy
) VALUES
('ODC-001', '온기 클래스랩', 'user2', '쿠킹', '성수 수제 파스타 원데이 클래스',
'직접 반죽한 생면으로 제철 채소 파스타와 크림 파스타를 완성하는 수업입니다.
반죽 밀기, 소스 농도 맞추기, 플레이팅까지 차근차근 따라오면 처음인 분도 무리 없이 완성할 수 있습니다.
수업 후에는 직접 만든 파스타를 식사하고 레시피 카드도 함께 드립니다.',
DATEADD('DAY', -12, CURRENT_TIMESTAMP), 59000, 0, 'class-thumb-01.svg', 2048, 'class-detail-01.svg', 4096, 10, 6, '서울 성수', 'N', 2, 28, 'user2', 'user2'),
('ODC-003', '온기 클래스랩', 'user2', '공예', '석고 방향제와 미니 트레이 만들기',
'석고 재료의 특성을 이해하고 기본 몰드 기법으로 방향제 2개와 미니 트레이 1개를 완성합니다.
마감 처리와 포장 팁까지 안내해 드려 선물용으로도 좋습니다.',
DATEADD('DAY', -10, CURRENT_TIMESTAMP), 52000, 3000, 'class-thumb-03.svg', 2048, 'class-detail-03.svg', 4096, 12, 7, '온라인', 'Y', 2, 19, 'user2', 'user2'),
('ODC-004', '온기 클래스랩', 'user2', '플라워', '주말 플라워 바스켓 스타일링',
'계절 꽃을 활용해 테이블용 플라워 바스켓을 완성하는 수업입니다.
꽃 고르기, 컬러 밸런스, 사진이 잘 나오는 배치법까지 함께 다룹니다.',
DATEADD('DAY', -9, CURRENT_TIMESTAMP), 68000, 0, 'class-thumb-04.svg', 2048, 'class-detail-04.svg', 4096, 10, 8, '서울 한남', 'N', 2, 31, 'user2', 'user2'),
('ODC-005', '온기 클래스랩', 'user2', '드로잉', '아이패드 감성 드로잉 입문',
'프로크리에이트 기본 브러시 사용법부터 색 조합, 텍스트 연출까지 익히는 클래스입니다.
카페 배경 일러스트와 인물 스케치를 주제로 작업합니다.',
DATEADD('DAY', -8, CURRENT_TIMESTAMP), 49000, 0, 'class-thumb-05.svg', 2048, 'class-detail-05.svg', 4096, 14, 9, '서울 합정', 'N', 2, 26, 'user2', 'user2'),
('ODC-006', '온기 클래스랩', 'user2', '향수', '나만의 시그니처 향수 블렌딩',
'탑 노트, 미들 노트, 베이스 노트의 구조를 이해하고 취향에 맞는 향을 직접 조향합니다.
완성한 30ml 향수와 블렌딩 기록지를 가져가실 수 있습니다.',
DATEADD('DAY', -7, CURRENT_TIMESTAMP), 79000, 0, 'class-thumb-06.svg', 2048, 'class-detail-06.svg', 4096, 8, 4, '서울 북촌', 'N', 2, 34, 'user2', 'user2'),
('ODC-007', '온기 클래스랩', 'user2', '가드닝', '베란다 허브 가드닝 클래스',
'바질, 로즈마리, 민트 등 허브 종류별 관리법과 분갈이 팁을 배웁니다.
직접 심은 화분 2종과 관리 캘린더를 제공합니다.',
DATEADD('DAY', -6, CURRENT_TIMESTAMP), 45000, 5000, 'class-thumb-07.svg', 2048, 'class-detail-07.svg', 4096, 16, 10, '온라인', 'Y', 2, 16, 'user2', 'user2'),
('ODC-008', '온기 클래스랩', 'user2', '도자기', '핸드빌딩 머그컵 만들기',
'코일링과 판성형 기법으로 머그컵을 직접 빚어 보는 입문 클래스입니다.
색 유약 선택과 건조, 소성 과정까지 자세히 설명합니다.',
DATEADD('DAY', -5, CURRENT_TIMESTAMP), 72000, 4000, 'class-thumb-08.svg', 2048, 'class-detail-08.svg', 4096, 10, 6, '서울 을지로', 'N', 2, 29, 'user2', 'user2'),
('ODC-009', '온기 클래스랩', 'user2', '캔들', '티라이트 캔들 2종 제작 워크숍',
'향 선택, 심지 고정, 색소 배합, 마감 포장까지 캔들 제작의 전 과정을 다룹니다.
티라이트 캔들과 필라 캔들을 각각 만들어 보실 수 있습니다.',
DATEADD('DAY', -4, CURRENT_TIMESTAMP), 56000, 0, 'class-thumb-09.svg', 2048, 'class-detail-09.svg', 4096, 12, 11, '서울 망원', 'N', 2, 22, 'user2', 'user2'),
('ODC-010', '온기 클래스랩', 'user2', '커피', '핸드드립 커피 브루잉 클래스',
'원두 분쇄도 조절과 추출 시간 체크를 중심으로 핸드드립의 핵심을 익히는 수업입니다.
원두별 향미 차이를 직접 비교해 보고 집에서도 재현할 수 있는 레시피를 정리합니다.',
DATEADD('DAY', -3, CURRENT_TIMESTAMP), 47000, 0, 'class-thumb-10.svg', 2048, 'class-detail-10.svg', 4096, 14, 12, '서울 서촌', 'N', 2, 37, 'user2', 'user2');

INSERT INTO qnaBBS (
    qUid, qTitle, qContent, qRegDate, qPos, qRef, qDepth, parentQNum, qOriUid, qFileName, qFileSize, qStatus, qCategory, cNum,
    createdBy, updatedBy
) VALUES
('admin', '[공지] 4월 신규 클래스 오픈 일정 안내',
'4월 셋째 주부터 성수, 연남, 북촌 스튜디오에서 신규 원데이 클래스가 순차적으로 오픈됩니다.
상세 일정은 각 클래스 상세 페이지에서 확인해 주세요.',
DATEADD('DAY', -10, CURRENT_TIMESTAMP), 0, 9001, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('admin', '[공지] 클래스 취소 및 환불 기준 안내',
'수업 3일 전까지는 전액 환불, 수업 1일 전까지는 50% 환불이 가능합니다.
당일 취소와 무단 불참은 재료 준비 특성상 환불이 어렵습니다.',
DATEADD('DAY', -9, CURRENT_TIMESTAMP), 0, 9002, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('admin', '[공지] 온라인 클래스 배송 일정 공지',
'온라인 클래스 재료 키트는 결제 완료 후 영업일 기준 1~2일 내 발송됩니다.
도서산간 지역은 1~2일 추가 소요될 수 있습니다.',
DATEADD('DAY', -8, CURRENT_TIMESTAMP), 0, 9003, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('admin', '[공지] 플라워 클래스 예약 안내',
'플라워 클래스는 계절 꽃 수급 상황에 따라 샘플 이미지와 일부 구성이 달라질 수 있습니다.
특정 컬러 요청은 사전 문의로 남겨 주세요.',
DATEADD('DAY', -7, CURRENT_TIMESTAMP), 0, 9004, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('admin', '[공지] 주말 클래스 입실 시간 안내',
'주말 수업은 시작 10분 전부터 입실 가능합니다.
스튜디오별 주차 지원 여부는 상세 페이지를 참고해 주세요.',
DATEADD('DAY', -6, CURRENT_TIMESTAMP), 0, 9005, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('admin', '[공지] 강사 지원서 검토 일정 안내',
'강사 입점 요청서는 접수 순서대로 검토되며 평균 3~5영업일이 소요됩니다.
수업 제안서와 포트폴리오를 구체적으로 작성해 주시면 검토가 빨라집니다.',
DATEADD('DAY', -5, CURRENT_TIMESTAMP), 0, 9006, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('admin', '[공지] 후기 작성 이벤트 안내',
'4월 한 달간 수강 후기를 작성해 주신 분께 다음 결제에 사용할 수 있는 포인트를 드립니다.
사진이 포함된 후기는 메인 추천 후기로 노출될 수 있습니다.',
DATEADD('DAY', -4, CURRENT_TIMESTAMP), 0, 9007, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('admin', '[공지] 동반 입장 가능 여부 안내',
'일부 클래스는 공간과 재료 문제로 동반 입장이 제한됩니다.
동반 가능 여부는 각 클래스 상세 설명을 확인해 주세요.',
DATEADD('DAY', -3, CURRENT_TIMESTAMP), 0, 9008, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('admin', '[공지] 기업 출강 문의 접수',
'기업 워크숍, 브랜드 행사, 팀 빌딩 클래스는 별도 출강 형태로 운영합니다.
희망 인원과 예산, 주제를 문의 게시판에 남겨 주세요.',
DATEADD('DAY', -2, CURRENT_TIMESTAMP), 0, 9009, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('admin', '[공지] 5월 연휴 운영 안내',
'5월 연휴 기간에도 일부 인기 클래스는 정상 운영됩니다.
배송 마감 일정은 별도 공지를 참고해 주세요.',
DATEADD('DAY', -1, CURRENT_TIMESTAMP), 0, 9010, 0, NULL, 'admin', NULL, NULL, 1, '공지', NULL, 'admin', 'admin'),
('user1', '성수 파스타 클래스 재료 준비가 필요한가요?',
'앞치마나 필기 도구를 개인적으로 챙겨 가야 하는지 궁금합니다. 재료는 모두 제공되나요?',
DATEADD('DAY', -2, CURRENT_TIMESTAMP), 0, 9101, 0, NULL, 'user1', NULL, NULL, 1, '수강생 관련', 1, 'user1', 'user1'),
('user2', '파스타 클래스는 재료와 앞치마를 모두 제공합니다.',
'필기 도구는 선택사항이고, 수업에 필요한 재료와 앞치마는 현장에서 모두 준비해 드립니다.
편한 복장으로만 와 주시면 됩니다.',
DATEADD('DAY', -1, CURRENT_TIMESTAMP), 1, 9101, 1, 11, 'user1', NULL, NULL, 1, '수강생 관련', 1, 'user2', 'user2'),
('user1', '답변 감사합니다. 혹시 포장 용기도 제공될까요?',
'집에 가져가서 가족과 같이 먹고 싶은데 포장 가능한지 궁금합니다.',
DATEADD('HOUR', -12, CURRENT_TIMESTAMP), 2, 9101, 2, 12, 'user2', NULL, NULL, 1, '수강생 관련', 1, 'user1', 'user1');

INSERT INTO reviewBBS (
    rUid, rTitle, rContent, rCnt, rLikes, rRegDate, rFileName, rFileSize, rStatus, cNum, createdBy, updatedBy
) VALUES
('user1', '파스타 클래스 덕분에 집에서도 재현했어요', '면 반죽부터 소스 농도까지 설명이 자세해서 집에서도 거의 비슷하게 만들 수 있었습니다.', 14, 5, DATEADD('DAY', -2, CURRENT_TIMESTAMP), NULL, NULL, 2, 1, 'user1', 'user1'),
('user1', '플라워 바스켓 선물용으로 최고였어요', '꽃 조합법과 색 균형을 쉽게 설명해 주셔서 만족스러웠습니다.', 9, 4, DATEADD('DAY', -1, CURRENT_TIMESTAMP), NULL, NULL, 2, 4, 'user1', 'user1'),
('user1', '핸드드립 클래스가 생각보다 실용적이었어요', '원두별 맛 차이를 직접 비교해 보면서 집에서도 쉽게 따라 할 수 있겠다고 느꼈습니다.', 7, 3, CURRENT_TIMESTAMP, NULL, NULL, 2, 10, 'user1', 'user1');

INSERT INTO levelUpBBS (
    lvlUid, lvlTitle, lvlContent, lvlName, lvlSns, lvlRegDate, lvlPos, lvlRef, lvlDepth, lvlFileName, lvlFileSize, lvlStatus, lvlOriUid,
    createdBy, updatedBy
) VALUES
('user1', '플라워 클래스 강사 입점 요청', '플라워샵 운영 경험을 바탕으로 테이블 센터피스와 시즌 꽃다발 클래스를 제안드립니다.', '하늘플라워', '@haneul.flower', DATEADD('DAY', -4, CURRENT_TIMESTAMP), 0, 7001, 0, NULL, NULL, 1, 'user1', 'user1', 'user1');

INSERT INTO requestBBS (
    reqUid, reqTitle, reqContent, reqRegDate, reqPos, reqRef, reqDepth, parentReqNum, reqOriUid, reqStatus, createdBy, updatedBy
) VALUES
('user1', '모바일에서 클래스 필터를 더 쉽게 보고 싶어요', '카테고리와 온라인/오프라인 필터가 한 번에 보이면 더 편할 것 같습니다. 모바일에서 특히 바로 선택하고 싶어요.', DATEADD('DAY', -3, CURRENT_TIMESTAMP), 0, 5001, 0, NULL, 'user1', 1, 'user1', 'user1'),
('admin', '모바일 필터 UI는 개선 예정입니다.', '좋은 의견 감사합니다. 상단 고정 필터와 모바일 전용 버튼형 필터 UI를 우선 검토하고 있습니다.', DATEADD('DAY', -2, CURRENT_TIMESTAMP), 1, 5001, 1, 1, 'user1', 1, 'admin', 'admin'),
('user1', '필터 선택 후 바로 결과가 보이면 좋겠습니다.', '적용 버튼 없이 바로 바뀌면 더 편할 것 같아요.', DATEADD('DAY', -1, CURRENT_TIMESTAMP), 2, 5001, 2, 2, 'admin', 1, 'user1', 'user1'),
('user2', '클래스 상세에 준비물 요약 박스가 있으면 좋겠어요', '상세 페이지를 끝까지 읽지 않아도 준비물과 소요시간을 한눈에 볼 수 있으면 좋겠습니다.', DATEADD('DAY', -1, CURRENT_TIMESTAMP), 0, 5002, 0, NULL, 'user2', 1, 'user2', 'user2');

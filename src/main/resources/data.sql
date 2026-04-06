INSERT INTO memberList (uId, uPw, uName, uPhone, uZip, uAddr1, uAddr2, uEmail, uLevel, sName, sSns)
SELECT 'admin', 'admin1234', 'Admin', '010-0000-0000', '00000', 'Seoul Gangnam', 'Admin Room', 'admin@oneday.local', '3', NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM memberList WHERE uId = 'admin');

INSERT INTO memberList (uId, uPw, uName, uPhone, uZip, uAddr1, uAddr2, uEmail, uLevel, sName, sSns)
SELECT 'teacher1', 'test1234', 'Teacher Kim', '010-1111-1111', '06236', 'Seoul Gangnam', 'Room 101', 'teacher1@oneday.local', '2', 'Kim Studio', '@teacher1'
WHERE NOT EXISTS (SELECT 1 FROM memberList WHERE uId = 'teacher1');

INSERT INTO memberList (uId, uPw, uName, uPhone, uZip, uAddr1, uAddr2, uEmail, uLevel, sName, sSns)
SELECT 'student1', 'test1234', 'Student Lee', '010-2222-2222', '04100', 'Seoul Mapo', 'Room 202', 'student1@oneday.local', '1', NULL, NULL
WHERE NOT EXISTS (SELECT 1 FROM memberList WHERE uId = 'student1');

INSERT INTO classBBS (
    cCode, cTeacher, cUid, cCategory, cTitle, cContent, cRegDate, cPrice, cDelivery,
    cThumbName, cThumbSize, cFileName, cFileSize, cMaxStu, cApplyStu, cArea, cOnoff, cStatus, cLikes
)
SELECT
    'CLS-001', 'Teacher Kim', 'teacher1', 'Cooking', 'Weekend Pasta Class', 'A beginner pasta class covering dough and sauce.',
    CURRENT_TIMESTAMP, 45000, 0, NULL, NULL, NULL, NULL, 12, 3, 'Seoul', 'N', 2, 7
WHERE NOT EXISTS (SELECT 1 FROM classBBS WHERE cCode = 'CLS-001');

INSERT INTO classBBS (
    cCode, cTeacher, cUid, cCategory, cTitle, cContent, cRegDate, cPrice, cDelivery,
    cThumbName, cThumbSize, cFileName, cFileSize, cMaxStu, cApplyStu, cArea, cOnoff, cStatus, cLikes
)
SELECT
    'CLS-002', 'Teacher Kim', 'teacher1', 'Craft', 'Rattan Basket Workshop', 'An online craft class you can join from home.',
    CURRENT_TIMESTAMP, 32000, 3000, NULL, NULL, NULL, NULL, 30, 8, 'Online', 'Y', 2, 11
WHERE NOT EXISTS (SELECT 1 FROM classBBS WHERE cCode = 'CLS-002');

INSERT INTO reviewBBS (rUid, rTitle, rContent, rCnt, rLikes, rRegDate, rFileName, rFileSize, rStatus, cNum)
SELECT 'student1', 'Great Pasta Class', 'Clear guidance and easy to follow for beginners.', 5, 2, CURRENT_TIMESTAMP, NULL, NULL, 2, 1
WHERE NOT EXISTS (SELECT 1 FROM reviewBBS WHERE rUid = 'student1' AND rTitle = 'Great Pasta Class');

INSERT INTO reviewBBS (rUid, rTitle, rContent, rCnt, rLikes, rRegDate, rFileName, rFileSize, rStatus, cNum)
SELECT 'student1', 'Nice Craft Session', 'Material guide was solid and the online flow worked well.', 3, 1, CURRENT_TIMESTAMP, NULL, NULL, 2, 2
WHERE NOT EXISTS (SELECT 1 FROM reviewBBS WHERE rUid = 'student1' AND rTitle = 'Nice Craft Session');

INSERT INTO levelUpBBS (
    lvlUid, lvlTitle, lvlContent, lvlName, lvlSns, lvlRegDate, lvlPos, lvlRef, lvlDepth, lvlFileName, lvlFileSize, lvlStatus, lvlOriUid
)
SELECT
    'student1', 'Teacher Upgrade Request', 'I have workshop experience and want to upgrade to teacher.', 'Lee Studio', '@student1craft',
    CURRENT_TIMESTAMP, 0, 1, 0, NULL, NULL, 1, 'student1'
WHERE NOT EXISTS (SELECT 1 FROM levelUpBBS WHERE lvlUid = 'student1' AND lvlTitle = 'Teacher Upgrade Request');

INSERT INTO classBBS (
    cCode, cTeacher, cUid, cCategory, cTitle, cContent, cRegDate, cPrice, cDelivery,
    cThumbName, cThumbSize, cFileName, cFileSize, cMaxStu, cApplyStu, cArea, cOnoff, cStatus, cLikes
)
SELECT
    CONCAT('CLS-SAMPLE-', RIGHT(CONCAT('00', seq.x), 2)),
    'Teacher Kim',
    'teacher1',
    CASE MOD(seq.x, 4)
        WHEN 0 THEN 'Cooking'
        WHEN 1 THEN 'Craft'
        WHEN 2 THEN 'Baking'
        ELSE 'Art'
    END,
    CONCAT('Sample Class ', seq.x),
    CONCAT('This is sample class content #', seq.x, ' for paging and board list testing.'),
    DATEADD('DAY', -seq.x, CURRENT_TIMESTAMP),
    20000 + (seq.x * 1000),
    CASE WHEN MOD(seq.x, 2) = 0 THEN 0 ELSE 3000 END,
    NULL, NULL, NULL, NULL,
    8 + MOD(seq.x, 12),
    MOD(seq.x, 7),
    CASE MOD(seq.x, 5)
        WHEN 0 THEN 'Seoul'
        WHEN 1 THEN 'Busan'
        WHEN 2 THEN 'Incheon'
        WHEN 3 THEN 'Daegu'
        ELSE 'Online'
    END,
    CASE WHEN MOD(seq.x, 2) = 0 THEN 'N' ELSE 'Y' END,
    2,
    MOD(seq.x * 3, 20)
FROM SYSTEM_RANGE(1, 30) seq
WHERE NOT EXISTS (
    SELECT 1 FROM classBBS c
    WHERE c.cCode = CONCAT('CLS-SAMPLE-', RIGHT(CONCAT('00', seq.x), 2))
);

INSERT INTO reviewBBS (rUid, rTitle, rContent, rCnt, rLikes, rRegDate, rFileName, rFileSize, rStatus, cNum)
SELECT
    'student1',
    CONCAT('Sample Review ', seq.x),
    CONCAT('Sample review content #', seq.x, '. The class flow, instructor delivery, and overall satisfaction are filled for list testing.'),
    MOD(seq.x, 15),
    MOD(seq.x, 8),
    DATEADD('HOUR', -seq.x, CURRENT_TIMESTAMP),
    NULL,
    NULL,
    2,
    c.cNum
FROM SYSTEM_RANGE(1, 30) seq
JOIN classBBS c ON c.cCode = CONCAT('CLS-SAMPLE-', RIGHT(CONCAT('00', seq.x), 2))
WHERE NOT EXISTS (
    SELECT 1 FROM reviewBBS r
    WHERE r.rTitle = CONCAT('Sample Review ', seq.x)
);

INSERT INTO qnaBBS (qUid, qTitle, qContent, qRegDate, qPos, qRef, qDepth, qOriUid, qFileName, qFileSize, qStatus, cNum)
SELECT
    'student1',
    CONCAT('Sample QnA ', seq.x),
    CONCAT('This is sample QnA content #', seq.x, '. I want to confirm schedule, materials, and participation details.'),
    DATEADD('MINUTE', -seq.x * 10, CURRENT_TIMESTAMP),
    0,
    1000 + seq.x,
    0,
    'student1',
    NULL,
    NULL,
    1,
    c.cNum
FROM SYSTEM_RANGE(1, 30) seq
JOIN classBBS c ON c.cCode = CONCAT('CLS-SAMPLE-', RIGHT(CONCAT('00', seq.x), 2))
WHERE NOT EXISTS (
    SELECT 1 FROM qnaBBS q
    WHERE q.qTitle = CONCAT('Sample QnA ', seq.x)
);

INSERT INTO levelUpBBS (
    lvlUid, lvlTitle, lvlContent, lvlName, lvlSns, lvlRegDate, lvlPos, lvlRef, lvlDepth, lvlFileName, lvlFileSize, lvlStatus, lvlOriUid
)
SELECT
    'student1',
    CONCAT('Sample Upgrade Request ', seq.x),
    CONCAT('Sample upgrade request content #', seq.x, '. I have portfolio items and workshop experience to be reviewed.'),
    CONCAT('Sample Studio ', seq.x),
    CONCAT('https://example.com/teacher/', seq.x),
    DATEADD('DAY', -seq.x, CURRENT_TIMESTAMP),
    0,
    2000 + seq.x,
    0,
    NULL,
    NULL,
    1,
    'student1'
FROM SYSTEM_RANGE(1, 30) seq
WHERE NOT EXISTS (
    SELECT 1 FROM levelUpBBS l
    WHERE l.lvlTitle = CONCAT('Sample Upgrade Request ', seq.x)
);

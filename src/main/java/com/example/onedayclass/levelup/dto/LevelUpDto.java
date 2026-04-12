package com.example.onedayclass.levelup.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LevelUpDto extends BaseVo {
    private Integer lvlNum; /* 등업 신청 번호 */
    private String lvlUid; /* 신청자 아이디 */
    @Size(min = 4, max = 80)
    private String lvlTitle; /* 등업 신청 제목 */

    @Size(min = 20, max = 3000)
    private String lvlContent; /* 등업 신청 내용 */

    @Size(min = 2, max = 50)
    @Pattern(regexp = "^$|^[가-힣a-zA-Z0-9\\s.,()_-]{2,50}$")
    private String lvlName; /* 활동명 또는 강사명 */

    @Size(max = 255)
    private String lvlSns; /* SNS 주소 */
    private String lvlRegDate; /* 등록일 */
    private Integer lvlPos; /* 답글 정렬 순서 */
    private Integer lvlRef; /* 원글 그룹 번호 */
    private Integer lvlDepth; /* 답글 깊이 */
    private String lvlFileName; /* 첨부 파일명 */
    private Integer lvlFileSize; /* 첨부 파일 크기 */
    private Integer lvlStatus; /* 상태값 */
    private String lvlOriUid; /* 원작성자 아이디 */
}

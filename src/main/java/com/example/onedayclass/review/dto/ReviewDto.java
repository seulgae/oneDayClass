package com.example.onedayclass.review.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDto extends BaseVo {
    private String rUid; /* 작성자 아이디 */
    private Integer rNum; /* 후기 번호 */

    @NotBlank
    @Size(min = 4, max = 80)
    private String rTitle; /* 후기 제목 */

    @NotBlank
    @Size(min = 10, max = 3000)
    private String rContent; /* 후기 내용 */
    private Integer rCnt; /* 조회수 */
    private Integer rLikes; /* 좋아요 수 */
    private String rRegDate; /* 등록일 */
    private String rFileName; /* 첨부 파일명 */
    private Integer rFileSize; /* 첨부 파일 크기 */
    private Integer rStatus; /* 상태값 */
    private Integer cNum; /* 클래스 번호 */
}

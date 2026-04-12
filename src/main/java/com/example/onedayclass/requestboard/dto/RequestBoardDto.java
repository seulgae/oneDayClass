package com.example.onedayclass.requestboard.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RequestBoardDto extends BaseVo {
    private Integer reqNum; /* 요청글 번호 */
    private String reqUid; /* 작성자 아이디 */
    @NotBlank
    @Size(min = 4, max = 80)
    private String reqTitle; /* 요청글 제목 */

    @NotBlank
    @Size(min = 10, max = 3000)
    private String reqContent; /* 요청글 내용 */
    private String reqRegDate; /* 등록일 */
    private Integer reqPos; /* 답글 정렬 순서 */
    private Integer reqRef; /* 원글 그룹 번호 */
    private Integer reqDepth; /* 답글 깊이 */
    private Integer parentReqNum; /* 부모 글 번호 */
    private String reqOriUid; /* 원작성자 아이디 */
    private Integer reqStatus; /* 상태값 */
}

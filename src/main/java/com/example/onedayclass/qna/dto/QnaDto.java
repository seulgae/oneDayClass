package com.example.onedayclass.qna.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class QnaDto extends BaseVo {
    private Integer qNum; /* 문의글 번호 */
    private String qUid; /* 작성자 아이디 */
    @NotBlank
    @Size(min = 4, max = 80)
    private String qTitle; /* 문의글 제목 */

    @NotBlank
    @Size(min = 10, max = 3000)
    private String qContent; /* 문의글 내용 */
    private String qRegDate; /* 등록일 */
    private Integer qPos; /* 답글 정렬 순서 */
    private Integer qRef; /* 원글 그룹 번호 */
    private Integer qDepth; /* 답글 깊이 */
    private Integer parentQNum; /* 부모 글 번호 */
    private String qOriUid; /* 원작성자 아이디 */
    private String qFileName; /* 첨부 파일명 */
    private Integer qFileSize; /* 첨부 파일 크기 */
    private Integer qStatus; /* 상태값 */
    private String qCategory; /* 문의 분류 */
    private Integer cNum; /* 클래스 번호 */
    private String cTitle; /* 연결된 클래스명 */
}

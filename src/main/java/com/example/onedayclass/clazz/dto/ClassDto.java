package com.example.onedayclass.clazz.dto;

import com.example.onedayclass.common.dto.BaseVo;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClassDto extends BaseVo {
    private Integer cNum; /* 클래스 번호 */
    private String cCode; /* 클래스 코드 */
    @NotBlank
    @Size(min = 2, max = 50)
    @Pattern(regexp = "^[가-힣a-zA-Z0-9\\s.,()_-]{2,50}$")
    private String cTeacher; /* 강사명 */
    private String cUid; /* 강사 아이디 */

    @NotBlank
    @Size(min = 2, max = 30)
    @Pattern(regexp = "^[가-힣a-zA-Z0-9\\s]{2,30}$")
    private String cCategory; /* 클래스 카테고리 */

    @NotBlank
    @Size(min = 4, max = 80)
    private String cTitle; /* 클래스 제목 */

    @NotBlank
    @Size(min = 20, max = 3000)
    private String cContent; /* 클래스 소개 내용 */
    private String cRegDate; /* 등록일 */

    @Min(0)
    @Max(10000000)
    private Integer cPrice; /* 수강 가격 */

    @Min(0)
    @Max(1000000)
    private Integer cDelivery; /* 배송비 */
    private String cThumbName; /* 썸네일 파일명 */
    private Integer cThumbSize; /* 썸네일 파일 크기 */
    private String cFileName; /* 첨부 파일명 */
    private Integer cFileSize; /* 첨부 파일 크기 */

    @Min(1)
    @Max(999)
    private Integer cMaxStu; /* 최대 수강 인원 */
    private Integer cApplyStu; /* 현재 신청 인원 */

    @NotBlank
    @Size(min = 2, max = 40)
    @Pattern(regexp = "^[가-힣a-zA-Z0-9\\s]{2,40}$")
    private String cArea; /* 진행 지역 */

    @NotBlank
    @Pattern(regexp = "^[NY]$")
    private String cOnoff; /* 온오프라인 여부 */
    private Integer cStatus; /* 상태값 */
    private Integer cLikes; /* 좋아요 수 */
}

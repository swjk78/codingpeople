# 검색 성능 테스트

## 게시판 검색

### 상위 게시판 검색

1. 상위 게시판 파악 후 검색 vs 검색 후 상위 게시판 파악

-   게시글 약 3100개, 표본 3만개 기준 테스트
-   maxTotal="20", minIdle="5", maxIdle="10", maxWait="3000"
-   100명의 이용자가 1초 간격으로 100번 반복
-   상위 게시판 파악 후 검색이 약 1.4배의 속도

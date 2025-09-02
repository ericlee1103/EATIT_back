<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!-- 파비콘 -->
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/favicon.ico" type="image/x-icon">
  <title>밥세권</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/community/viewOtherPost.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/community/treeGrade.css" />
  <script defer src="${pageContext.request.contextPath}/assets/js/community/reportPostModal.js"></script>
  <script defer src="${pageContext.request.contextPath}/assets/js/community/viewOtherPost.js"></script>
  <script defer src="${pageContext.request.contextPath}/assets/js/community/darkmode.js"></script>
  <script defer src="${pageContext.request.contextPath}/assets/js/community/treeGradeModal.js"></script>
  <script>
    let headerPath = '../../header.jsp';
    let footerPath = '../../footer.jsp';
  </script>
  <script defer src="${pageContext.request.contextPath}/assets/js/header.js"></script>
</head>

<body>
  <!-- 헤더 -->
<!--   <header id="header"></header> -->
  <jsp:include page="/header.jsp" />

  <aside class="side"></aside>

  <main class="main">
	  <div class="container">
	
	    <!-- 카테고리 메뉴 -->
	    <nav class="category_container">
	      <ul class="category_list">
	        <li class="category_item"><a href="${pageContext.request.contextPath}/community/communityMainOk.co">공지사항/이벤트</a></li>
	        <li class="category_item"><a href="${pageContext.request.contextPath}/community/freeBoardReadOk.co">자유게시판</a></li>
	        <li class="category_item"><a href="${pageContext.request.contextPath}/community/promoBoardListOk.co">홍보게시판</a></li>
	        <li class="category_item"><a href="${pageContext.request.contextPath}/community/recipeListOk.co">레시피</a></li>
	      </ul>
	    </nav>
	
	    <!-- 게시글 -->
	    <article>
	      <div class="post">
	        <!-- 게시글 헤더 -->
	        <div class="post_header">
	          <div class="post_box">
	            <!-- 작성자 -->
	            <div class="author_box">
	              <img src="${pageContext.request.contextPath}/assets/img/관리자.png" alt="관리자" class="tree_icon" />
	              <span>${post.memberId}</span>
	            </div>
	
	            <!-- 게시글 제목 -->
	            <div class="post_title">
	              <h1 class="post_title"><c:out value="${post.postTitle}" /></h1>
	            </div>
	
	            <!-- 메타 데이터 -->
	            <div class="post_meta">
	              <div class="post_date_area">
	                <p>${post.postCreatedDate}</p>
	              </div>
	              <div class="post_hit_area">
	                <span>조회</span>
	                <span><c:out value="${post.postViewCount}" /></span>
	              </div>
	              <div class="post_like_area">
	                <span>추천</span>
	                <span><c:out value="${post.postLikeCount}" /></span>
	              </div>
	            </div> <!-- .post_meta -->
	          </div> <!-- .post_box -->
	        </div> <!-- .post_header -->
	
	        <!-- 게시글 내용 -->
	        <section class="content_section">
	          <div class="view-content">
	            <h3><c:out value="${post.freeContent}" /></h3>
	          </div>
	
	          <!-- 수정/삭제 버튼 -->
	          <div class="post_buttons">
	            <div class="func_button">
	              <c:if test="${sessionScope.memberNumber eq post.getMemberNumber()}">
	                <button type="button" class="modify-btn edit"
	                  data-board-number="${post.postNumber}"
	                  data-member-number="${sessionScope.memberNumber}">수정</button>
	
	                <button type="button" class="delete-btn delete"
	                  data-board-number="${post.postNumber}"
	                  data-member-number="${sessionScope.memberNumber}">삭제</button>
	              </c:if>
	            </div>
	          </div>
	        </section>
	
	        <!-- 추천/신고 버튼 -->
	        <div class="post_buttons">
	          <button class="recommend" id="recommendBtn" title="게시글 추천하기">
	            <img src="${pageContext.request.contextPath}/assets/img/like.jpg" alt="추천 버튼" />
	          </button>
	          <span class="recommend_count" id="recommendCount">추천 0</span>
	          <button type="button" class="report" id="openReportModal" title="신고하기">신고</button>
	        </div>
	      </div> <!-- .post -->
	    </article>
	
	    <!-- 댓글 영역 -->
	    <section class="comment_section">
	      <h2 class="comment_count">
	        <img src="${pageContext.request.contextPath}/assets/img/comment_box.svg" alt="댓글 아이콘" />
	        댓글
	      </h2>
	
	      <ul class="comment_list" id="commentList"><!-- JS가 채움 --></ul>
	
	      <form class="comment_form" id="commentForm" onsubmit="return false;">
	        <img class="comment_profile" src="${pageContext.request.contextPath}/assets/img/나무.png" alt="프로필" />
	        <span class="comment_author">
	          <c:choose>
	            <c:when test="${not empty sessionScope.memberId}">
	              ${sessionScope.memberId}
	            </c:when>
	            <c:otherwise>비회원</c:otherwise>
	          </c:choose>
	        </span>
	        <input type="text" id="commentInput" name="comment" placeholder="댓글을 입력하세요" required />
	        <button type="button" id="commentSubmit">등록</button>
	      </form>
	    </section>
	
	    <!-- 다크 모드 버튼 -->
	    <button id="darkModeToggle" title="다크 모드 토글">🌓</button>
	
	  </div> <!-- .container -->
	</main>
  

  <!-- 신고 모달 -->
  <div class="modal_bg" id="reportModal">
    <div class="modal">
      <h2>게시글 신고하기</h2>
      <form id="reportForm">
        <div class="report_reasons">
          <label><input type="radio" name="reason" value="스팸/광고" required> 스팸/광고</label>
          <label><input type="radio" name="reason" value="욕설/비방"> 욕설/비방</label>
          <label><input type="radio" name="reason" value="음란물"> 음란물</label>
          <label><input type="radio" name="reason" value="개인정보 노출"> 개인정보 노출</label>
          <label><input type="radio" name="reason" value="기타"> 기타</label>
        </div>
        <div class="modal_buttons">
          <button type="button" id="cancelReport">취소</button>
          <button type="submit" id="submitReport">신고하기</button>
        </div>
      </form>
    </div>
  </div>

  <!-- 나무 등급 정보 모달 -->
  <div id="treeInfoModal" class="tree_modal_bg" aria-hidden="true" role="dialog" aria-labelledby="treeInfoTitle"
    aria-modal="true">
    <div class="tree_modal" role="document">
      <button id="closeTreeInfoModal" aria-label="닫기" class="tree_modal_close_btn">&times;</button>
      <h2 id="treeInfoTitle">나무 등급 정보</h2>
      <div id="treeInfoContent"></div>
    </div>
  </div>



  <!-- 푸터 -->
  <jsp:include page="/footer.jsp" />
<!--   <footer id="footer"></footer> -->
  
</body>
<script>
  window.ctx = "${pageContext.request.contextPath}";
  window.postNumber = ${post.postNumber != null ? post.postNumber : 'null'};
  window.memberNumber = ${sessionScope.memberNumber != null ? sessionScope.memberNumber : 'null'};

  console.log("DEBUG: postNumber =", window.postNumber);
  console.log("DEBUG: memberNumber =", window.memberNumber);
</script>
</html>
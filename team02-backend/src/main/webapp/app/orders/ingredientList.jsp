<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:url value="/assets/img/placeholder.png" var="ph"/>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/orders/storeList.css">
  <script defer src="${pageContext.request.contextPath}/assets/js/header.js"></script>
  <script defer src="${pageContext.request.contextPath}/assets/js/orders/storeList.js"></script>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/img/favicon.ico" type="image/x-icon">
  <title>밥세권 - 재료 목록</title>
</head>

<body>
  <!-------------------- 헤더 ------------------------>
  <jsp:include page="${pageContext.request.contextPath}/header.jsp">
    <jsp:param name="active" value="purchase"/>
  </jsp:include>

  <!-- 구매>재료구매 가게 목록 리스트  -->
  <main id="buy">
    <div class="wrap">
      <div class="buy_store_list">
        <h2>재료 구매 🥕</h2>

        <!-- 검색 -->
        <form method="get" action="${pageContext.request.contextPath}/orders/ingredientList.or">
          <input type="text" name="q" id="buy_search" value="${q}" placeholder="재료나 가게를 찾아보세요!" autocomplete="off"/>
          <input type="hidden" name="itemType" value="INGREDIENT"/>
        </form>

        <!-- 정렬 -->
        <ul class="buy_array">
          <li><a href="${pageContext.request.contextPath}/orders/ingredientList.or?itemType=INGREDIENT&q=${param.q}&sort=recent">최신순</a></li>
          <li><a href="${pageContext.request.contextPath}/orders/ingredientList.or?itemType=INGREDIENT&q=${param.q}&sort=priceAsc">가격↑</a></li>
          <li><a href="${pageContext.request.contextPath}/orders/ingredientList.or?itemType=INGREDIENT&q=${param.q}&sort=priceDesc">가격↓</a></li>
        </ul>

        <!-- DB에서 불러온 재료 리스트 -->
        <div class="buy_area">
          <c:choose>
            <c:when test="${empty items}">
              <p style="color:#888">표시할 재료가 없습니다.</p>
            </c:when>
            <c:otherwise>
              <c:forEach var="item" items="${items}">
                <article class="buy_food_article">
                  <a href="${pageContext.request.contextPath}/orders/storeDetail.or?itemNumber=${item.itemNumber}">
                    <img src="${empty item.itemImageSystemName ? ph : pageContext.request.contextPath += '/upload/items/' += item.itemImageSystemName}" 
                         alt="${item.itemName}"/>
                    <div class="buy_store_info">
                      <p class="buy_store_name">${item.businessName}</p>
                      <p class="buy_menu_name">${item.itemName}</p>
                      <p class="buy_item_content">
                        <c:out value="${item.itemContent}" default="설명 없음"/>
                      </p>
                      <p class="buy_price">
                        <fmt:formatNumber value="${item.itemPrice}" type="number"/>원
                      </p>
                    </div>
                  </a>
                </article>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- 페이지네이션 -->
        <c:if test="${totalPages > 1}">
          <nav class="buy_pagenation">
            <ul>
              <c:forEach begin="1" end="${totalPages}" var="p">
                <li class="buy_pagenation_box ${p == page ? 'active' : ''}">
                  <a href="${pageContext.request.contextPath}/orders/storeList.or?page=${p}&itemType=INGREDIENT&q=${param.q}&sort=${param.sort}">${p}</a>
                </li>
              </c:forEach>
            </ul>
          </nav>
        </c:if>

      </div>
    </div>
  </main>

  <jsp:include page="${pageContext.request.contextPath}/footer.jsp" />
</body>
</html>

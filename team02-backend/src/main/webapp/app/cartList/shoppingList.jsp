<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/cartList/shoppingList.css">

<script defer src="${pageContext.request.contextPath}/assets/js/header.js"></script>
<script>
  const contextPath = "${pageContext.request.contextPath}";
</script>

<title>밥세권 - 장바구니</title>
</head>

<body>
  <!-- 헤더 -->
  <jsp:include page="${pageContext.request.contextPath}/header.jsp" />

  <main id="shopping_list">
    <div id="wrap">
      <!-- 상단 제목 -->
      <div class="shopping_header">장바구니 🛒</div>

      <div class="shopping_content">
        <!-- 왼쪽: 장바구니 목록 -->
        <div class="shopping_cart_area">

          <!-- 전체선택 + 선택삭제 + 전체삭제 -->
          <div class="shopping_select_all">
            <input type="checkbox" id="selectAll"> 전체선택
            <button type="button" id="deleteSelected" class="shopping_select_delete">선택삭제</button>
            <button type="button" id="clearAll" class="shopping_select_delete">전체삭제</button>
          </div>

          <!-- 선택삭제용 숨은 form -->
          <form id="deleteForm" action="${pageContext.request.contextPath}/cartList/deleteSelectedOk.cl" method="post">
            <input type="hidden" name="cartItemNumbers" id="cartItemNumbers">
          </form>

          <!-- 장바구니 목록 -->
          <div class="shopping_cart_list">
            <c:choose>
              <c:when test="${empty items}">
                <p class="empty">
                  장바구니가 비어 있습니다. <br>
                  <a href="${pageContext.request.contextPath}/orders/storeList.or" class="go_store">메뉴 보러가기 →</a>
                </p>
              </c:when>
              <c:otherwise>
                <c:set var="sampleImgs" value="/assets/img/food1.jpg,/assets/img/food2.jpg,/assets/img/food3.jpg,/assets/img/food4.jpg,/assets/img/food5.jpg,/assets/img/food6.jpg,/assets/img/food7.jpg,/assets/img/food8.jpg,/assets/img/food9.jpg,/assets/img/food10.jpg,/assets/img/food11.jpg,/assets/img/food12.jpg" />
                <c:set var="sampleArr" value="${fn:split(sampleImgs, ',')}" />

                <c:forEach var="item" items="${items}">
                  <c:set var="sampleImg" value="${sampleArr[item.itemNumber % fn:length(sampleArr)]}" />
                  <c:url value="${sampleImg}" var="dummyUrl" />

                  <div class="shopping_cart_item" data-item-id="${item.itemNumber}">
                    <!-- 선택 체크박스 -->
                    <input type="checkbox" class="shopping_item_check" name="cartItemNumber" value="${item.cartItemNumber}">

                    <!-- 이미지 -->
                    <c:choose>
                      <c:when test="${empty item.imagePath}">
                        <img src="${dummyUrl}" alt="${item.itemName}">
                      </c:when>
                      <c:otherwise>
                        <c:url value="/upload/items/${item.imagePath}" var="itemImg" />
                        <img src="${itemImg}" alt="${item.itemName}">
                      </c:otherwise>
                    </c:choose>

                    <!-- 상품 정보 -->
                    <div class="shopping_item_info">
                      <a href="${pageContext.request.contextPath}/orders/storeDetail.or?itemNumber=${item.itemNumber}" class="shopping_item_name">${item.itemName}</a>
                      <div class="shopping_item_price">
                        <fmt:formatNumber value="${item.cartItemPrice}" type="number" /> 원
                      </div>
                    </div>

                    <!-- 수량 조절 -->
                    <div class="shopping_item_cnt">
                      <button type="button" class="cnt_btn minus" data-item="${item.itemNumber}" data-qty="${item.cartItemQuantity - 1}">-</button>
                      <span class="qty">${item.cartItemQuantity}</span>
                      <button type="button" class="cnt_btn plus" data-item="${item.itemNumber}" data-qty="${item.cartItemQuantity + 1}">+</button>
                    </div>

                    <!-- 단건 삭제 -->
                    <div class="shopping_item_delete">
                      <a href="${pageContext.request.contextPath}/cartList/deleteItemOk.cl?cartItemNumber=${item.cartItemNumber}">삭제</a>
                    </div>
                  </div>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <!-- 오른쪽: 결제 영역 -->
        <div class="shopping_payment_area">
          <form action="${pageContext.request.contextPath}/orders/paymentReady.or" method="post" id="paymentForm">
            <input type="hidden" name="cartItemNumbers" id="payCartItemNumbers">

            <!-- 결제금액 -->
            <div class="shopping_payment_summary">
              <div class="shopping_payment_title">결제금액</div>
              <div class="shopping_price_row">
                <span>선택 상품 금액</span> 
                <span id="selectedAmount">0 원</span>
              </div>
            </div>

            <!-- 결제 버튼 -->
            <button type="submit" class="shopping_payment_btn" ${empty items ? 'disabled' : ''}>
              결제하기
            </button>
          </form>
        </div>
      </div>
    </div>
  </main>

  <footer id="footer"></footer>

  <!-- 장바구니 JS -->
  <script src="${pageContext.request.contextPath}/assets/js/cartList/shoppingList.js"></script>
</body>
</html>

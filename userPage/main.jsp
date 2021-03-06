<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import = "user.dao.UserMenuDAO" %>
    <%@ page import = "admin.dto.ProductDTO" %>
    <%@ page import = "java.util.*" %>
    <% request.setCharacterEncoding("UTF-8");%>
    
<title>BAD GUDU</title>
<div id="main" align="center">
<%--사이드 메뉴 끌어오기 --%>
<%@ include file ="aside.jsp" %>

<link href="style.css" rel="stylesheet" type="text/css">


<%
	//등록된 상품의 총 개수
	int productCount = 0;
	UserMenuDAO dao = new UserMenuDAO();
	productCount = dao.getProductCount();
	
	//한 페이지에 보여질 게시물 수
	int pageSize = 8;
	
	//한 줄에 보여질 게시물 수
	int col = 4;
	
	//리스트에스 페이지 번호 클릭 시 받는 파라미터.
	String pageNum = request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	//상품 썸네일 가져오기
	List thumbnailImgList = dao.getThumbnailImg(startRow, endRow);
	String thumbnailImg = "";
	
	//상품 이름, 가격 가져오기
	List thumbnailPdList = null;
	thumbnailPdList = dao.getThumbnailPd(startRow, endRow);
%>


<main>
<h1><a class="title" href="main.jsp">BAD GUDU</a></h1>
<br />

<table width = "1200" border="1">
<%
	for(int i = 0; i<thumbnailPdList.size(); i++){
		thumbnailImg = thumbnailImgList.get(i).toString();
		ProductDTO dto = (ProductDTO)thumbnailPdList.get(i);
		if(i%col ==0){
			%> <tr align='center'><%
		}
		%><td>
			<table width='300' onClick="location.href='product.jsp?pdCode=<%=dto.getPdCode() %>'" style="cursor:pointer;"
			>
				<tr align='center'> 
				<td> <%
					if(thumbnailImg == null){
						%>대표 이미지를 입력해주세요 <br ><%
					} else{
						%><img src="${pageContext.request.contextPath}\productImg\<%=thumbnailImg %>" width="270" height="270"/><%
					} %> </td></tr>
				<tr align="center"><td><strong><%=dto.getProductName() %></strong></td></tr>
				<tr align="right"><td> <%=dto.getSellingPrice() %>원</td></tr>
				</table><%
	}
%>
</table>

<br />
<br />
<%
	if(productCount>0){
		int pageCount = productCount / pageSize + (productCount%pageSize == 0 ? 0:1);
		
		int startPage = (int)(currentPage/10)*10+1;
		int pageBlock = 10;
		int endPage = startPage+pageBlock-1;
		if (endPage>pageCount) {
			endPage = pageCount;
		}
		if (startPage>10){
			%> <a href="main.jsp?pageNum=<%=startPage-10 %>"> [이전]</a><%
		}
		for(int i = startPage; i <= endPage; i++){
			%> <a href="main.jsp?pageNum=<%=i %>">[<%=i %>]</a><%
		}
		if (endPage<pageCount) {
			%> <a href="main.jsp?pageNum=<%=startPage+10 %>">[다음]</a><%
		}
	}

%>
</div>
</main>
<%@ page contentType="text/html;charset=UTF-8" %>


<%@ page import= "membersJava.BoardDBBean" %>
<%@ page import= "membersJava.BoardDataBean" %>
<%@ page import = "java.sql.Timestamp" %>

<% request.setCharacterEncoding("UTF-8");%>


<%
  int num =Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("pageNum");
   String passwd = request.getParameter("passwd");

  BoardDBBean dbPro = new BoardDBBean();
  int check = dbPro.deleteArticle(num, passwd);
  
  if(check==1){
%>
   <meta http-equiv="Refresh" content="0;url=Mlist.jsp?pageNum<%=pageNum%>" >
   <%}else{ %>
   <script language="Javascript">
  alert("비밀번호가 맞지 않습니다");
        history.go(-1);
</script>

<%} %>
<%@ page contentType="text/html; charset=UTF-8" %> 
<% request.setCharacterEncoding("utf-8"); %> 
<%
	String root=request.getContextPath(); 
	String id=(String)session.getAttribute("id");
	String grade=(String)session.getAttribute("grade");
	System.out.print(id);
	System.out.print(grade);
%>

 
<!DOCTYPE html>
<html>
<title>W3.CSS Template</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"> 
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", sans-serif}
body, html {
    height: 100%;
    line-height: 1.8;
}
.w3-bar .w3-button {
    padding: 16px;
}
</style>



</head> 
<!-- *********************************************** -->

<body>

<!-- 리본 메뉴(왼쪽) -->
<div class="w3-top">
  <div class="w3-bar w3-white w3-card" id="myNavbar">
  
    <a href="<%=root%>/index.jsp" class="w3-bar-item w3-button w3-wide">HOME</a>
    
    <%if(id!=null){%>
    	<a href="<%=root%>/member/read.jsp" class="w3-bar-item w3-button w3-wide">MyInfo</a>
    <%if(id!=null && grade.equals("A")){%>
    	<li id="admin"><a href="<%=root%>/admin/list.jsp" class="w3-bar-item w3-button w3-wide">회원목록</a>
    	
    <%}%>
    	<a href="<%=root%>/member/logout.jsp" class="w3-bar-item w3-button w3-wide">로그아웃</a>
    	<a href="<%=root%>/member/deleteForm.jsp" class="w3-bar-item w3-button w3-wide">탈퇴</a>
    <%} %>
    
    
    
<!-- 리본메뉴(오른쪽) -->
    <div class="w3-right w3-hide-small">
      <a href="<%=root%>/post/list.jsp" class="w3-bar-item w3-button"><img src='<%=root %>/imges/pen.png'>게시판</a>
      <a href="<%=root%>/photo/list.jsp" class="w3-bar-item w3-button"><i class="fa fa-user"></i>이미지</a>
      <a href="<%=root%>/guest/list.jsp" class="w3-bar-item w3-button"><i class="fa fa-th"></i> 방명록</a>


	<%if(id==null){%>
      <a href="<%=root %>/member/loginForm.jsp" class="w3-bar-item w3-button"><img src='<%=root %>/imges/login.png'></i> 로그인</a>
      <a href="<%=root%>/member/agreement.jsp" class="w3-bar-item w3-button"> 회원가입</a>
    <%}%> 
    </div>
    <!-- Hide right-floated links on small screens and replace them with a menu icon -->

    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>


<!-- *********************************************** -->

</body>
<!-- *********************************************** -->
</html> 


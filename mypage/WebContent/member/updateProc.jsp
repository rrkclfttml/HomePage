<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="mymember.MemberDAO"/>
<jsp:useBean id="dto" class="mymember.MemberDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	boolean flag=dao.update(dto);
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function mread(){
	var url="read.jsp";
	url=url+"?id=<%=dto.getId()%>";
	location.href=url;
}
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
<br><br><br>
<DIV class="title"></DIV>
 <%
 	if(flag){
 		out.print( "정보변경을 했습니다.");
 	}else{
 		out.print("정보변경을 실패했습니다.");
 	}
 
 %>


  <DIV class='bottom'>
<%if(flag){ %>
    <input type='button' value='나의 정보' onclick="mread()">
<%}else{ %>
    <input type='button' value='다시시도' onclick="history.back()">
 <%} %> 
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


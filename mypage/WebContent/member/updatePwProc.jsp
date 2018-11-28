<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="mymember.MemberDAO"/>
<jsp:useBean id="dto" class="mymember.MemberDTO"/>
<%
	String id=request.getParameter("id");
	String neww=request.getParameter("neww");
	String oldpasswd=request.getParameter("oldpasswd");
	
	Map map=new HashMap();
	map.put("id", id);
	map.put("neww", neww);

	

	boolean flag=dao.updatePasswd(map);
	
%>


 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 


<script type="text/javascript">
function read(){
	var url="read.jsp";
	url=url+"?id=<%=id%>";
	location.href=url;
}
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
<br><br><br> 
<DIV class="title">비밀번호 변경</DIV>
 <%
	if(flag){
		out.print("비밀번호를 변경했습니다.");
	}else{
		out.print("변경에 실패했습니다.");
	}
 
 %>

 <DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
    <input type='button' value='확인' onclick="read()">
  </DIV>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


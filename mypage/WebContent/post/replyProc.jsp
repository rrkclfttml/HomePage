<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="post.PostDAO"/>
<jsp:useBean id="dto" class="post.PostDTO"/>
<jsp:setProperty name="dto" property="*"/>

<%
	Map map=new HashMap();
	map.put("grpno",dto.getGrpno());
	map.put("ansnum",dto.getAnsnum());
	dao.upAnsnum(map);
	boolean flag=dao.replyCreate(dto);

%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
</head> 


<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <br><br><br>
<DIV class="title">답글 등록 결과</DIV>
 
<div>
<%
	if(flag){
		out.print("주소등록을 성공했습니다.");
	}else{
		out.print("주소등록이 실패했습니다.");
	}
%>

</div>
  
  <DIV class='bottom'>
    <input type='button' value='글 등록' onclick="location.href='createForm.jsp'">
    <input type='button' value='목록' onclick="location.href='list.jsp'">
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


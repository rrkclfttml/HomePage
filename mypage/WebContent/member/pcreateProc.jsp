<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="mymember.MemberDAO"/>
<%
	String tempDir="/member/temp";
	String upDir="/member/storage";
	
	tempDir=application.getRealPath(tempDir);
	upDir=application.getRealPath(upDir);
	
	UploadSave upload=new UploadSave(request,-1,-1,tempDir);
	
	String id=upload.getParameter("id");
	String email=upload.getParameter("email");
	String str="";
	
	if(dao.checkId(id)){
		str="중복된 아이디입니다. 아이디 중복확인을 하세요.";
	}else if(dao.checkEmail(email)){
		str="중복된  email입니다. Email중복을 확인하세요.";
	}else{
		request.setAttribute("upload", upload);
	
	
%>
 
 <jsp:forward page="/member/createProc.jsp"/>
<%
	return;
	}
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
<DIV class="title">ID 및 Email 중복확인</DIV>
 
<div class="content">
<%=str %>
</div> 

  
  <DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>

 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


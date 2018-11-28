<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="photo.PhotoDAO" />
 
<%
	String upDir=application.getRealPath("/photo/storage");
	int photono=Integer.parseInt(request.getParameter("photono"));
	String passwd=request.getParameter("passwd");
	String oldfile=dao.getimg(photono);
	
	Map map=new HashMap();
	map.put("photono",photono);
	map.put("passwd",passwd);
	
	boolean cf=dao.passcheck(map);
	boolean flag=false;
	if(cf){
		flag=dao.delete(photono);
		if(oldfile!=null)
			UploadSave.deleteFile(upDir, oldfile);
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
<DIV class="title"></DIV>
 
<FORM name='frm' method='POST' action='./'>
<h2>처리결과</h2>
<%if(flag){
	out.print("삭제되었습니다");
}else if(!cf){
	out.print("비밀번호가 일치하지 않습니다");
}else{
	out.print("삭제 실패");
}
%>
<div>
<%if(flag){%>
<input type="button" value="목록" onclick="location.href='list.jsp'">
<%}else if(!cf){ %>
<input type="button" value="다시시도" onclick="history.back()">
<input type="button" value="목록" onclick="location.href='list.jsp'">
<%}else{ %>
<input type="button" value="목록" onclick="location.href='list.jsp'">
<%} %>
</div>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


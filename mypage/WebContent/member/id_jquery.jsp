<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="mymember.MemberDAO"/>

<%
	String id=request.getParameter("id");
	boolean flag=dao.checkId(id);


	if(flag){
		out.print("중복되어서 사용할 수 없습니다.");
	}else{
		out.print("사용이 가능합니다.");
	}
%> 


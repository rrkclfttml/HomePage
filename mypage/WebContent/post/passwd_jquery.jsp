<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="post.PostDAO" />
<jsp:useBean id="dto" class="post.PostDTO" />


<%
	String passwd=request.getParameter("passwd");
	int postno=Integer.parseInt(request.getParameter("postno"));
//	System.out.println(passwd);
//	System.out.println(postno);
	
	Map map=new HashMap();
	map.put("passwd",passwd);
	map.put("postno",postno);
	
	boolean flag=dao.passwdCheck(map);
	if(flag){
		out.print("비밀번호가 맞습니다.");
	}else{
		out.print("비밀번호가 틀립니다.");
	}
%>



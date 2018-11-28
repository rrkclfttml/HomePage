<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="mymember.MemberDAO"/>
 
<%
	String id=request.getParameter("id");
	String passwd=request.getParameter("passwd");
	
	Map map=new HashMap();
	map.put("id",id);
	map.put("pw",passwd);
	
	boolean flag=dao.loginCheck(map);
	if(flag){
		String grade=dao.getGrade(id);
		session.setAttribute("id", id);
		session.setAttribute("grade", grade);
		
		Cookie cookie=null;
		String c_id=request.getParameter("c_id");
		if(c_id!=null){
			cookie=new Cookie("c_id","Y");
			cookie.setMaxAge(120);
			response.addCookie(cookie);
			
			cookie = new Cookie("c_id_val", id); 
		    cookie.setMaxAge(120);                
		    response.addCookie(cookie); 
		}else{ 
		      cookie = new Cookie("c_id", "");     
		      cookie.setMaxAge(0); 
		      response.addCookie(cookie); 
		         
		      cookie = new Cookie("c_id_val", "");  
		      cookie.setMaxAge(0); 
		      response.addCookie(cookie);
		}
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
<DIV class="title">로그인 처리</DIV>
<div class="content">
<%
	if(flag){
		out.print("로그인이 되었습니다.");
	}else{
		out.print("잘못입력하셨거나 <br>");
		out.print("회원이 아닙니다. 회원가입을 진행해주세요.");
	}
%>

</div>
<br>
  <DIV class='bottom'>
    <input type='submit' value=' 홈 ' onclick="location.href='../index.jsp'">
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>

 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


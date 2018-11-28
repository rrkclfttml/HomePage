<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="post.PostDAO"/>
<%
	int postno=Integer.parseInt(request.getParameter("postno"));
	String passwd=request.getParameter("passwd");
	String oldfile=request.getParameter("oldfile");
	
	Map map=new HashMap();
	map.put("postno",postno);
	map.put("passwd",passwd);
	
	boolean pflag=dao.passwdCheck(map);
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
 
<DIV class="title"></DIV>
 
<FORM name='frm' method='POST' action='./'>
  <TABLE>
    <TR>
      <TH></TH>
      <TD></TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value=''>
    <input type='button' value='' onclick="location.href=''">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


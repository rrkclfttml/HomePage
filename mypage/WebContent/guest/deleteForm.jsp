<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<%
	request.setCharacterEncoding("utf-8");
	int gno=Integer.parseInt(request.getParameter("gno"));
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
 
<FORM name='frm' method='POST' action='./deleteProc.jsp'>
<input type="hidden" name="gno" value="<%=gno%>">
 <div>
		삭제를 하면 복구 될 수 없습니다.<br>
		<br> 삭제하시려면 삭제버튼을 클릭하세요<br>
		<br> 취소는 '목록'버튼을 누르세요 <br>
 
  <DIV class='bottom'>
    <input type='submit' value='삭제'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="photo.PhotoDAO"/>
 
<%	
	int photono=Integer.parseInt(request.getParameter("photono"));
	
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
 
 <h2>삭제</h2>
 삭제시 복구할 수 없습니다.<br>
 삭제를 원하시면 아래 패스워드를 입력하시고<br>
 삭제버튼을 누르십시오.
<FORM name='frm' method='POST' action='./deleteProc.jsp'>
<input type="hidden" name="photono" value="<%=photono%>">
	<table class="table table-striped">
		<tr>
			<th></th>
			<td><input type="password" name="passwd">
				<button>삭제</button>
				<button type="button" onclick="read()">취소</button></td>
		</tr>
	</table>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


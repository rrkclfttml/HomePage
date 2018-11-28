<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<%
	int gno=Integer.parseInt(request.getParameter("gno"));

	GuestDAO dao=new GuestDAO();
	GuestDTO dto=dao.read(gno);
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function check(f){
	if(f.title.value==""){
		alert("제목을 입력하세요");
		f.title.focus();
		return false;
	}
	if(f.content.value==""){
		alert("내용을 입력하세요");
		f.content.focus();
		return false;
	}
}
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
<br><br><br> 
<DIV class="title"></DIV>
 
<FORM name='frm' method='POST' action='./updateProc.jsp' onsubmit="return check(this)">
<input type="hidden" name="gno" value="<%=gno %>">
  <TABLE>
      <TH>제목</TH>
      <TD><input type="text" name="title" size="20"
      		value="<%=dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea row="10" cols="20" name="content">
      			<%=dto.getContent() %></textarea>
      </TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='수정'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


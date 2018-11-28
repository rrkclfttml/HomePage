<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<%	request.setCharacterEncoding("utf-8");%>
<jsp:useBean id="dao" class="guest.GuestDAO"/>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function check(f){
	if(f.title.vlaue==""){
		alert("제목을 입력하세요.");
		f.title.focus();
		return false;
	}
	if(f.content.value==""){
		alert("내용을 입력하세요.");
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
 
<FORM name='frm' method='POST' action='./createProc.jsp' onsubmit="return check(this)">
  <TABLE>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" size="40" value=""></TD>
    </TR>
    <TR>
      <TH>내용</TH>
      <TD><textarea rows="9" cols="20" name="content"></textarea>
      </TD>
    </TR>
  </TABLE>
  
  <DIV class='bottom'>
    <input type='submit' value='등록'>
    </DIV>
</FORM>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="post.PostDAO"/> 
 
<%
	int postno=Integer.parseInt(request.getParameter("postno"));
	PostDTO dto=dao.replyRead(postno);
%>
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title>답변</title> 

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>


</head> 
<script type="text/javascript">
function incheck(f){
	if(f.title.value==""){
		alert("제목을 입력하세요.");
		f.title.focus();
		return false;
	}
	if(f.pname.value==""){
		alert("이름을 입력하세요.");
		f.pname.focus();
		return false;
	}
	if(f.content.value==""){
		alert("답변을 입력하세요.");
		f.content.focus();
		return false;
	}
	if(f.passwd.value==""){
		alert("비밀번호를 입력하세요.");
		f.passwd.focus();
		return false;
	}
}



</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
 
<script type="text/JavaScript">
  window.onload=function(){
   CKEDITOR.replace('content');
  };
  </script>
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <br><br><br>
<DIV class="title">답변</DIV>
 
<FORM name='frm' method='POST' action='./replyProc.jsp' onsubmit="return incheck(this)">

<input type="hidden" name="postno" value="<%=dto.getPostno() %>">
<input type="hidden" name="grpno" value="<%=dto.getGrpno()%>">
<input type="hidden" name="indent" value="<%=dto.getIndent()%>">
<input type="hidden" name="ansnum" value="<%=dto.getAnsnum() %>">
  <TABLE>
    <TR>
      <TH>제목</TH>
      <TD><input type="text" name="title" value="<%=dto.getTitle()%>"></TD>
    </TR>
    <TR>
      <TH>성명</TH>
      <TD><input type="text" name="pname"></TD>
    </TR>
    <TR>
      <TH>답변</TH>
      <TD><textarea rows="3" cols="60" name="content"></textarea></TD>
    </TR>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd">
       </TD>
    </TR>
  </TABLE>
<br>
  <DIV class='bottom'>
    <input type='submit' value='등록'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
<br><br>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="post.PostDAO"/>

<%
	int postno=Integer.parseInt(request.getParameter("postno"));
	boolean flag=dao.checkRefnum(postno);
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function plist(){
	var url="list.jsp";
	location.href=url;
}

function incheck(f){
	if(f.passwd.value==""){
		alter("비밀번호를 입력하세요.");
		f.passwd.focus();
		return false;
	}
}
</script>
</head> 
<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <br><br><br>
<% if(flag){ %>
<DIV class="title">삭제</DIV>
	<div class="title">삭제</div>
	<div class="content">답글이 존재하므로 게시글을 삭제 할 수 없습니다.</div>
	<div class='bottom'>
		<input type='button' value='목록' onclick='plist()'>
	</div>

<%}else{  %>	 
	<div class="title">삭제</div>
	<div class="content">삭제하면 복구할 수 없습니다.</div>
	
	<FORM name='frm' method='POST' action='./deleteProc.jsp'
		onsubmit="return incheck(this)">
	<input type="hidden" name="postno" value="<%=postno %>">
	<input type="hidden" name="oldfile" value="<%=request.getParameter("oldfile")%>">
  <TABLE>
    <TR>
      <TH>비밀번호</TH>
      <TD><input type="password" name="passwd"></TD>
    </TR>
  </TABLE>
  <br>
  <DIV class='bottom'>
    <input type='submit' value='확인'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
</FORM>
<%} %>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


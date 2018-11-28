<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="mymember.MemberDAO"/>
 
<%
	String id=request.getParameter("id");
	String passwd=request.getParameter("passwd");
	
	MemberDTO dto=dao.read(id);
	
%> 
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<script type="text/javascript">
function inCheck(f){
	if(f.oldpasswd.value!="<%=dto.getPasswd()%>"){
		alert("기존비밀번호가 맞지 않습니다.");
		f.oldpasswd.focus();
		return false;
	}
	if(f.passwd.value==""){
		alert("비밀번호를 입력하세요.");
		f.passwd.focus();
		return false;
	}
	if(f.repasswd.value==""){
		alert("비밀번호 확인을 입력하세요.");
		f.repasswd.focus();
		return false;
	}
	if(f.passwd.value!=f.repasswd.value){
		alert("비밀번호가 일치하지 않습니다.");
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
<DIV class="title"></DIV>
 
<DIV class="title">비밀번호 변경</DIV>
<div style="margin: 10px auto">
<FORM name='frm' method='POST' action='./updatePwProc.jsp'
		onsubmit="return inCheck(this)">
<input type="hidden" name="id" value="<%=id %>">

  
<table>
  <tr>
  	<th>기존비밀번호 입력</th>
  	<td><input type="password" name="oldpasswd"></td> 
  </tr>
</table>
</div>
 

<br>
<br>
  
  <TABLE>
    <TR>
      <TH>패스워드</TH>
      <TD><input type="password" name="neww"></TD>
    </TR>
    <TR>
      <TH>패스워드확인</TH>
      <TD><input type="password" name="repasswd"></TD>
    </TR>
  </TABLE>
  
    <DIV class='bottom'>
    <input type='submit' value='수정'>
    <input type='button' value='취소' onclick="history.back()">
  </DIV>
  
 </form>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


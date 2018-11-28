<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="guest.GuestDAO"/>

<%
	int gno=Integer.parseInt(request.getParameter("gno"));

	dao.updateViewcnt(gno);
	
	GuestDTO dto=dao.read(gno);
	String content=dto.getContent();
	content=content.replaceAll("\r\n","<br>");
%>
 
<!DOCTYPE html> 
<html> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
<script type="text/javascript">
function gcreate(){
	var url="createForm.jsp";
	location.href=url;
}
function gupdate(memono){
	var url="updateForm.jsp";
	url=url+"?gno="+<%=gno%>;
	location.href=url;
}
function gdelete(memono){
	var url = "deleteForm.jsp";
	url += "?gno="+<%=gno%>;
	location.href=url;
}
function glist(){
	var url = "list.jsp";
	location.href=url;
}
function greply(){
	var url="replyForm.jsp";
	url=url+"?gno=<%=gno%>";
	location.href=url;
}
</script>
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
<br><br><br>

<div>조회</div>
<table>
	<tr>
		<th>제목</th>
		<td><%=dto.getTitle() %></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><%=dto.getContent() %></td>
	</tr>
	<tr>
		<th>조회수</th>
		<td><%=dto.getViewcnt() %></td>
	</tr>
	<tr>
		<th>등록일</th>
		<td><%=dto.getWdate() %></td>
	</tr>
</table>
  
  <DIV class='bottom'>  
    <input type='button' value='목록' onclick="glist()">
    <input type='button' value='등록' onclick="gcreate()">
    <input type='button' value='수정' onclick="gupdate()">
    <input type='button' value='삭제' onclick="gdelete('<%=dto.getGno()%>')">
  </DIV>
 
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="photo.PhotoDAO" />

<%
	request.setCharacterEncoding("utf-8");
	int photono = Integer.parseInt(request.getParameter("photono"));
	
	dao.viewcnt(photono);
	PhotoDTO dto = dao.read(photono);

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<script type="text/javascript">


	function read(no) {
		var url = "./read.jsp";
		url += "?photono=" + <%=dto.getPhotono()%>;

		location.href = url;
	}
	function pupdate() {
		var url = "updateForm.jsp";
		url += "?photono=<%=dto.getPhotono()%>";
		url += "&oldfile=<%=dto.getPhoto()%>"

		location.href = url;
	}

	function pdel() {
		var url = "deleteForm.jsp";
		url += "?photono=<%=dto.getPhotono()%>";
		url += "&oldfile=<%=dto.getPhoto()%>"

		location.href = url;
	}
	function preply() {
		var url = "./replyForm.jsp";
		url += "?photono=" + <%=dto.getPhotono()%>;

		location.href = url;
	}
</script>

<style type="text/css">
.curImg {
	margin-right: 0;
	border-style: solid;
	border-width: 3px;
	border-color: red;
}

.td_padding {
	padding: 5px 5px;
}
</style>


</head>
<!-- *********************************************** -->
<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->
<br>
<br><br>
	

	<TABLE class="w3-table w3-bordered w3-card-4" style="width: 50%;">
		<tr>
			<td colspan="2" style="text-align: center"><img
				src="./storage/<%=dto.getPhoto()%>" width="80%"></td>
		</tr>
		<TR>
			<TH>번호</TH>
			<TD><%=dto.getPhotono()%></TD>
		</TR>
		<TR>
			<TH>제목</TH>
			<TD><%=dto.getTitle()%></TD>
		</TR>
		<TR>
			<TH>작성자</TH>
			<TD><%=dto.getName()%></TD>
		</TR>
		<TR>
			<TH>작성일</TH>
			<TD><%=dto.getMdate()%></TD>
		</TR>
	</TABLE>
<br>
	<table class="w3-table w3-bordered w3-card-4" style="width: 50%;">

		<tr>
			<%
				List list = dao.photoRead(photono);
				int[] noArr = (int[]) list.get(0);
				String[] files = (String[]) list.get(1);

				for (int i = 0; i < 5; i++) {
					if (files[i] == null) {
					
			%>
			<td class="td_padding" style="text-align: center">
			<img src="../images/default.jpg" width="150px" border="0">
			</td>
			<%
				} else{
					if (noArr[i] == photono) {
						
			%>
			<td class="td_padding" style="text-align: center">
			<a href="javascript:read('<%=noArr[i]%>')"> 
			<img class="curImg"	src="./storage/<%=files[i]%>" width="170px" border="0">
			</a></td>

			<%
					}else {
			%>

			<td class="td_padding" style="text-align: center"><a
				href="javascript:read('<%=noArr[i]%>')"> <img
					src="./storage/<%=files[i]%>" width="170px" border="0">
			</a></td>

			<%
					}
				}
			}
			%>
		
	</table>

	<DIV class='bottom'>
		<input class="w3-btn w3-white w3-border w3-border-green w3-round-large" type='button' value='수정' onclick="pupdate()"> 
		<input class="w3-btn w3-white w3-border w3-border-green w3-round-large" type='button' value='삭제' onclick="pdel()"> 
		<input class="w3-btn w3-white w3-border w3-border-green w3-round-large" 
			type='button' value='목록' onclick="location.href='./list.jsp'">
		<input class="w3-btn w3-white w3-border w3-border-green w3-round-large" 
			type='button' value='답글' onclick="preply()">
	</DIV>


	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>
<!-- *********************************************** -->
</html>

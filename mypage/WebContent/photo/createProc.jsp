<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../ssi/ssi.jsp"%>
<jsp:useBean id="dao" class="photo.PhotoDAO" />
<jsp:useBean id="dto" class="photo.PhotoDTO" />

<%
	String upDir = "/photo/storage";
	String tempDir = "/photo/temp";
	upDir = application.getRealPath(upDir);
	tempDir = application.getRealPath(tempDir);

	UploadSave upload = new UploadSave(request, -1, -1, tempDir);
	String title = UploadSave.encode(upload.getParameter("title"));
	String name = UploadSave.encode(upload.getParameter("name"));
	String passwd = UploadSave.encode(upload.getParameter("passwd"));

	FileItem fileItem = upload.getFileItem("photo");
	String photo = UploadSave.saveFile(fileItem, upDir);

	dto.setTitle(title);
	dto.setName(name);
	dto.setPhoto(photo);
	dto.setPasswd(passwd);
	boolean flag = dao.create(dto);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>

<body>
	<jsp:include page="/menu/top.jsp" flush="false" />
	<!-- *********************************************** -->
	<br>
	<br>
	<br>

	<DIV class="title"></DIV>

	<div class="content">
		<%
			if (flag) {
				out.print("사진등록이 성공했습니다.");
			} else {
				out.print("실패했습니다.");
			}
		%>
	</div>

		<DIV class='bottom'>
			<input type='button' value='홈'> 
			<input type='button' value='다시시도' onclick="history.back()">
			<input type='button' value='리스트' onclick="location.href='list.jsp'">
			<input type='button' value='다른 사진 올리기' onclick="location.href='createForm.jsp'">
		</DIV>


		<!-- *********************************************** -->
		<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>

</html>


<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../ssi/ssi.jsp"%>
<jsp:useBean id="dto" class="photo.PhotoDTO" />
<jsp:useBean id="dao" class="photo.PhotoDAO" />

<%
	String upDir = application.getRealPath("/photo/storage");
	String tempDir = application.getRealPath("/photo/temp");

	UploadSave upload = new UploadSave(request, -1, -1, tempDir);

	FileItem fileItem = upload.getFileItem("photo");

	String photo = null;
	String title = UploadSave.encode(upload.getParameter("title"));
	String name = UploadSave.encode(upload.getParameter("name"));
	String passwd = UploadSave.encode(upload.getParameter("passwd"));
	int grpno = Integer.parseInt(upload.getParameter("grpno"));
	int indent = Integer.parseInt(upload.getParameter("indent"));
	int ansnum = Integer.parseInt(upload.getParameter("ansnum"));

	int size = (int) fileItem.getSize();
	if (size > 0) {
		photo = UploadSave.saveFile(fileItem, upDir);
	}

	dto.setTitle(title);
	dto.setName(name);
	dto.setPhoto(photo);
	dto.setPasswd(passwd);
	dto.setGrpno(grpno);
	dto.setIndent(indent);
	dto.setAnsnum(ansnum);

	Map map = new HashMap();
	map.put("grpno", dto.getGrpno());
	map.put("ansnum", dto.getAnsnum());
	dao.upAnsnum(map);

	boolean flag = dao.replyCreate(dto);
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
<br><br><br>
	<DIV class="title"></DIV>

<div class="content">
<% 
if(flag){
	out.print("답변글이 등록되었습니다.");
}else{
	out.print("답변글 등록을 실패했습니다.");
}
%>
</div>
		<DIV class='bottom'>
			<input type='button' value='목록' onclick="location.href='list.jsp'"> 
			<input type='button' value='사진등록' onclick="location.href='createProc.jsp'">
		</DIV>
	</FORM>


	<!-- *********************************************** -->
	<jsp:include page="/menu/bottom.jsp" flush="false" />
</body>

</html>


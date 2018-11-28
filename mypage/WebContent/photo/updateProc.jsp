<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dao" class="photo.PhotoDAO"/>
<jsp:useBean id="dto" class="photo.PhotoDTO"/>

<%
	String upDir = application.getRealPath("/photo/storage");
	String tempDir = application.getRealPath("/photo/temp");
	
	UploadSave upload = new UploadSave(request,-1,-1,tempDir);
	
	int photono = Integer.parseInt(upload.getParameter("photono"));
	String title = UploadSave.encode(upload.getParameter("title"));
	String name = UploadSave.encode(upload.getParameter("name"));
	String oldfile = UploadSave.encode(upload.getParameter("oldfile"));
	String passwd = UploadSave.encode(upload.getParameter("passwd"));
	
	FileItem fileItem = upload.getFileItem("photo");
	
	String photo = "";
	if(fileItem.getSize()>0){
		UploadSave.deleteFile(upDir, oldfile);
		photo = UploadSave.saveFile(fileItem, upDir);
	}
	dto.setTitle(title);
	dto.setName(name);
	dto.setPhotono(photono);
	dto.setPasswd(passwd);
	dto.setPhoto(photo);
	
	Map map = new HashMap();
	map.put("photono", dto.getPhotono()); 
	map.put("passwd", dto.getPasswd());
	
	System.out.println("photono:"+dto.getPhotono());
	System.out.println("passwd:"+dto.getPasswd());
	
	boolean pflag = dao.passcheck(map);	
	boolean flag = false;
	if(pflag){
	 	flag=dao.update(dto);
	 }
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
<%
if(pflag==false){
	out.print("비밀번호가 일치하지 않습니다.");
	
}else if(flag){
	out.print("내용 수정을 성공했습니다.");
}else{
	out.print("내용 수정을 실패했습니다.");
}
%>

  <DIV class='bottom'>
    <input type='button' value='목록' onclick="location.href='list.jsp'">
    <input type='button' value='다시시도' onclick="history.back()">
  </DIV>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


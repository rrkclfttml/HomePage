<%@ page contentType="text/html; charset=UTF-8" %> 
<%@ include file="../ssi/ssi.jsp"%> 
<jsp:useBean id="dto" class="post.PostDTO"/>
<jsp:useBean id="dao" class="post.PostDAO"/>

<%
	String tempDir=application.getRealPath("/post/temp");
	String upDir=application.getRealPath("/post/storage");
	
	UploadSave upload=new UploadSave(request,-1,-1,tempDir);

	dto.setPname(UploadSave.encode(upload.getParameter("pname")));
	dto.setTitle(UploadSave.encode(upload.getParameter("title")));
	dto.setContent(UploadSave.encode(upload.getParameter("content")));
	dto.setPasswd(upload.getParameter("passwd"));
	
	dto.setPostno(Integer.parseInt(upload.getParameter("postno")));
	String col=upload.getParameter("col");
	String word=UploadSave.encode(upload.getParameter("word"));
	String nowPage=upload.getParameter("nowPage");
	String oldfile=UploadSave.encode(upload.getParameter("oldfile"));
	
	FileItem fileItem=upload.getFileItem("filename");
	int filesize=(int)fileItem.getSize(); 
	String filename=null;
	
	Map map=new HashMap();
	map.put("postno",dto.getPostno());
	map.put("passwd",dto.getPasswd());
	
	boolean pflag=dao.passwdCheck(map);
	boolean flag=false;
	if(pflag){
		if(filesize>0) {
			if(oldfile!=null) UploadSave.deleteFile(upDir, oldfile); // 기존의 올라가 있던 파일을 지운다.
			filename=UploadSave.saveFile(fileItem, upDir);
			}
		
		dto.setFilename(filename);
		dto.setFilesize(filesize);
		
		flag=dao.update(dto);
	}

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

</script> 
</head> 

<body>
<jsp:include page="/menu/top.jsp" flush="false"/>
<!-- *********************************************** -->
 <br><br><br>
<DIV class="title">결과 </DIV>
 
 <br><br>
<%
 	if(pflag==false){
 		out.print("패스워드가 일치하지 않습니다.");
 	}else if(flag){
 		out.print("글이 수정되었습니다.");
 	}else{
 		out.print("글 수정이 실패했습니다.");
 	}
 	
 %> 
  </div>
   <DIV class='bottom'>
    <input type='button' value='다시시도' onclick="history.back()">
    <input type='button' value='목록' onclick="plist()">
  </DIV>
 
<!-- *********************************************** -->
<jsp:include page="/menu/bottom.jsp" flush="false"/>
</body>

</html> 


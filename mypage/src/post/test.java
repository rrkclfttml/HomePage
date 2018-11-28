package post;

import post.PostDTO;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import mymember.MemberDTO;


public class test {

	public static void main(String[] args) {
		PostDAO dao=new PostDAO();
		//list(dao);
		//create(dao);
		read(dao);
		//update(dao);
		//delete(dao);
		//upviewcnt(dao);
		//passwdCheck(dao);
		

	}

	private static void read(PostDAO dao) {
		PostDTO dto=new PostDTO();
		dto=dao.read(4);
		p(dto);
		
	}

	private static void p(PostDTO dto) {
			p("번호: "+dto.getPostno());
			p("글쓴이 : "+dto.getPname());
			p("글제목 : "+dto.getTitle());
			p("글내용 : "+dto.getContent());
			p("조회수 : "+dto.getViewent());
			p("등록날짜 : "+dto.getWdate());		
			p("grpno : "+dto.getGrpno());		
			p("ansnum : "+dto.getAnsnum());		
			p("파일이름: "+dto.getFilename());
			p("파일사이즈: "+dto.getFilesize());
	}

	private static void p(String string) {
		System.out.println(string);	
		
	}

}
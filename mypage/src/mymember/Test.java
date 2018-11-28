package mymember;

import post.PostDAO;
import post.PostDTO;

public class Test {

	public static void main(String[] args) {
		PostDAO dao=new PostDAO();
		read(dao);

	}

	private static void read(PostDAO dao) {
		PostDTO dto=new PostDTO();
		dto=dao.read(1);
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
		
	}

	private static void p(String string) {
		System.out.println(string);
		
	}

}

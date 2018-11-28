package photo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import db.DBClose;
import db.DBOpen;




public class PhotoDAO {

	public boolean create(PhotoDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		StringBuffer sql=new StringBuffer();
		sql.append(" insert into photo(photono,title,name,photo, passwd, mdate,grpno) ");
		sql.append(" values((select nvl(max(photono),0)+1 as photono from photo), ");
		sql.append(" ?,?,?,?, sysdate, ");
		sql.append(" (select nvl(max(grpno),0)+1 as photono from photo) ) ");

		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getName());
			ps.setString(3, dto.getPhoto());
			ps.setString(4, dto.getPasswd());

			int cnt=ps.executeUpdate();
			if(cnt>0)flag=true;

			} catch (SQLException e) {
			e.printStackTrace();
			}finally {
			DBClose.close(ps, con);
			}		
		return flag;
	}
	
	
	
	
	public PhotoDTO  read(int photono) {
		PhotoDTO dto=null;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT photono, name, title, photo, mdate from photo ");
		sql.append(" WHERE photono=? ");

		try {
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, photono);

			rs = ps.executeQuery();

			if (rs.next()) {
				dto = new PhotoDTO();
				dto.setPhotono(rs.getInt("photono"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setPhoto(rs.getString("photo"));
				dto.setMdate(rs.getString("mdate"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBClose.close(rs, ps, con);
		}
		
		return dto;
	}
	
	
	public List photoRead(int no) {
		List list = new ArrayList();
		Connection con = DBOpen.open();
		PreparedStatement ps= null;
		ResultSet rs = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT * FROM  ");
		sql.append("   (  ");
		sql.append("      select    ");
		sql.append("          lag(photono,2)     over (order by photono) pre_no2,    ");
		sql.append("          lag(photono,1)     over (order by photono ) pre_no1,   ");
		sql.append("          photono,  ");
		sql.append("          lead(photono,1)    over (order by photono) nex_no1,    ");
		sql.append("          lead(photono,2)    over (order by photono) nex_no2,    ");
		sql.append("          lag(photo,2)  over (order by photono) pre_file2,     ");
		sql.append("          lag(photo,1)  over (order by photono ) pre_file1,  ");
		sql.append("          photo,   ");
		sql.append("          lead(photo,1) over (order by photono) nex_file1,  ");
		sql.append("          lead(photo,2) over (order by photono) nex_file2   ");
		sql.append("          from (  ");
		sql.append("               SELECT photono, photo   ");
		sql.append("               FROM photo ");
		sql.append("               ORDER BY photono DESC  ");
		sql.append("          )  ");
		sql.append("   )  ");
		sql.append("   WHERE photono = ? ");

		try {
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, no);

			rs = ps.executeQuery();

			if (rs.next()) {
				String[] files = { rs.getString("pre_file2"),
						rs.getString("pre_file1"),
						rs.getString("photo"),
						rs.getString("nex_file1"),
						rs.getString("nex_file2") };
				int[] noArr = { rs.getInt("pre_no2"),
						rs.getInt("pre_no1"),
						rs.getInt("photono"),
						rs.getInt("nex_no1"),
						rs.getInt("nex_no2") };

				list.add(noArr);
				list.add(files);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, ps, con);
		}

		return list;
	}

	
	
	
	
	public List<PhotoDTO> list(Map map){
		List<PhotoDTO> list=new ArrayList<PhotoDTO>();
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		String col=(String)map.get("col");
		String word=(String)map.get("word");
		int sno=(Integer)map.get("sno");
		int eno=(Integer)map.get("eno");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select photono, title, name, photo, grpno, indent,  ");
		sql.append(" 		ansnum, passwd, viewcnt, mdate, r ");
		sql.append(" from( ");
		sql.append(" 	select photono, title, name, photo, grpno, indent,  ");
		sql.append(" 		ansnum, passwd, viewcnt, mdate, rownum as r  ");
		sql.append(" 	from( ");
		sql.append(" 		select photono, title, name, photo, grpno, indent,  ");
		sql.append(" 		ansnum, passwd, viewcnt,  ");
		sql.append(" 		to_char(mdate,'yyyy-mm-dd') as mdate ");
		sql.append(" 		from photo ");
		if(word.trim().length()>0)
			sql.append(" 		where " + col + " like '%'||?||'%' ");
		sql.append(" 		order by grpno desc, ansnum ");
		sql.append(" 	) ");
		sql.append(" ) where r>= ? and r<= ? ");
		
		int i = 0 ;
		try {
			ps = con.prepareStatement(sql.toString());
			if(word.trim().length()>0)
				ps.setString(++i, word);
			
			ps.setInt(++i, sno);
			ps.setInt(++i, eno);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				PhotoDTO dto = new PhotoDTO();
				dto.setPhotono(rs.getInt("photono"));
				dto.setTitle(rs.getString("title"));
				dto.setName(rs.getString("name"));
				dto.setPhoto(rs.getString("photo"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setMdate(rs.getString("mdate"));
				
				list.add(dto);			
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, ps, con);
		}
		
		return list;
	}

	
	
	
	
	public boolean update(PhotoDTO dto) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" update photo ");
		sql.append(" set title = ?, ");
		sql.append(" name = ?, ");
		sql.append(" photo = ? ");
		sql.append(" where photono = ? ");
		
		try {
			ps = con.prepareStatement(sql.toString());
			ps.setString(1, dto.getTitle());
			ps.setString(2, dto.getName());
			ps.setString(3, dto.getPhoto());
			ps.setInt(4, dto.getPhotono());
			
			int cnt = ps.executeUpdate();			
			if(cnt>0) {
				flag = true;
			}			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;
	}
	
	
	
	
	public boolean delete(int photono) {
		boolean flag=false;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" delete from photo ");
		sql.append(" where photono=? ");

		try {
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, photono);

			int cnt = ps.executeUpdate();
			if (cnt > 0)
				flag = true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(ps, con);
		}	
		return flag;
	}
	
	
	
	public boolean replyCreate(PhotoDTO dto) {
		boolean flag=false;
		Connection con = DBOpen.open();
		PreparedStatement ps=null;
		StringBuffer sql=new StringBuffer();
		
		sql.append(" insert into photo ");
		sql.append(" (photono,name,title,photo,grpno,indent,ansnum,passwd,viewcnt,mdate) ");
		sql.append(" values((select nvl(max(photono),0)+1 as photono from photo), ");
		sql.append(" ?,?,?,?,?,?,?,?,sysdate) ");
		
		try {
			ps = con.prepareStatement(sql.toString());
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getTitle());
			ps.setString(3, dto.getPhoto());
			ps.setInt(4, dto.getGrpno());
			ps.setInt(5, dto.getIndent()+1);
			ps.setInt(6, dto.getAnsnum()+1);
			ps.setString(7, dto.getPasswd());
			ps.setInt(8, dto.getViewcnt());
			
			int cnt = ps.executeUpdate();
			
			if(cnt>0) flag = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(ps, con);
		}
		
		return flag;		
	}
	
	
	
	public PhotoDTO replyread(int photono) {
		PhotoDTO dto=null;
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
	
		StringBuffer sql=new StringBuffer();
		sql.append(" select photono, title, grpno, indent, ansnum  ");
		sql.append(" from photo ");
		sql.append(" where photono = ? ");
		
		try {
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, photono);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				dto = new PhotoDTO();
				dto.setPhotono(rs.getInt("photono"));
				dto.setTitle(rs.getString("title"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		
		return dto;
	}
	
	
	public String getimg(int photono) {
		String oldfile="";
		Connection con=DBOpen.open();
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		StringBuffer sql=new StringBuffer();
		sql.append(" select photo from photo where photono=? ");
		
		try {
			ps=con.prepareStatement(sql.toString());
			ps.setInt(1, photono);
			
			rs=ps.executeQuery();
			if(rs.next())
				oldfile=rs.getString("photo");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			DBClose.close(rs, ps, con);
		}
		
		return oldfile;
	}
	
	
	public int total(Map map) {
		int total = 0;
		
		Connection con = DBOpen.open();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from photo ");
		if(word.trim().length()>0)
			sql.append(" 	where " + col + " like  '%'||?||'%'  ");
		
		try {
			ps = con.prepareStatement(sql.toString());
			if(word.trim().length()>0)
				ps.setString(1, word);
			
			rs = ps.executeQuery();
			
			rs.next();
			
			total = rs.getInt(1); // 첫번째 가져온 데이터를 total 에 담음
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, ps, con);
		}

		return total;
	
	}
	
	public void upAnsnum(Map map) {
		Connection con = DBOpen.open();
		PreparedStatement ps = null;
		int grpno = (Integer)map.get("grpno");
		int ansnum = (Integer)map.get("ansnum");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" update photo ");
		sql.append(" set ansnum = ansnum + 1 ");
		sql.append(" where grpno = ? ");
		sql.append(" and ansnum > ? ");

		try {
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, grpno);
			ps.setInt(2, ansnum);
			
			ps.executeUpdate();			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(ps, con);
		}
		
	}
	
	
	public void viewcnt(int photono) {
		Connection con = DBOpen.open();
		PreparedStatement ps = null;
		StringBuffer sql = new StringBuffer();
		sql.append(" update photo ");
		sql.append(" set viewcnt = viewcnt + 1 ");
		sql.append(" where photono =? ");
		
		try {
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, photono);
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(ps, con);
		}		

	}
	
	
	
	public boolean passcheck(Map map) {
		boolean flag = false;
		Connection con = DBOpen.open();
		PreparedStatement ps= null;
		ResultSet rs = null;

		int photono = (Integer) map.get("photono");
		String passwd = (String) map.get("passwd");

		StringBuffer sql = new StringBuffer();
		sql.append(" select count(passwd) from photo ");
		sql.append(" where photono=? and passwd=? ");

		try {
			ps = con.prepareStatement(sql.toString());
			ps.setInt(1, photono);
			ps.setString(2, passwd);

			rs = ps.executeQuery();
			if (rs.next()) {
				int cnt = rs.getInt(1);
				if (cnt > 0)
					flag = true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DBClose.close(rs, ps, con);
		}

		return flag;
	}

	
}

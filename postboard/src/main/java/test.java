import java.text.SimpleDateFormat;
import java.util.Date;

public class test {

	public static void main(String[] args) {
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		String today = simpleDateFormat.format(date);
		System.out.print(today);
		
				
	}

	
	
}

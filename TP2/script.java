import java.util.* ;
import java.io.*;


public class script {
	public static void main(String[] args){
		try {
			BufferedReader buf = new BufferedReader(new FileReader("dic-finance-en.ptOrig.txt"));
			String linha = null ;

			PrintWriter writer = new PrintWriter("out.txt");

			while((linha = buf.readLine())!=null){
				writer.println(linha.toUpperCase());

			}

			writer.close();

		}catch(IOException e) {
			e.printStackTrace();
		}

		
	}
}


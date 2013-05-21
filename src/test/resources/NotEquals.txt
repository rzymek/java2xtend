public class Test {
    String txt;

    @Override
    public boolean equals(Object obj) {        
        if (!txt.equals(((Test)obj).txt)) {
            return false;
        }
        if(!(txt != obj)){
        	return false;
        }
        return true;
    }
}